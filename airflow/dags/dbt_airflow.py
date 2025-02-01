from airflow import DAG
from airflow.models import Variable
from airflow.operators.python import PythonOperator
from datetime import datetime
import subprocess
import logging


dbt_project_path = Variable.get("dbt_project_path")
 
def run_dbt_test():
    command = f"cd {dbt_project_path} && dbt test"
    logging.info(f"Executando: {command}")
   
    try:
        result = subprocess.run(
            command,
            capture_output=True,
            text=True,
            shell=True,
            check=True         #fará com que uma exceção seja lançada

        )

        logging.info(f"Saída padrão (stdout): {result.stdout}")
        logging.info(f"Erro padrão (stderr): {result.stderr}")
        logging.info("dbt test executado com sucesso.")

    except subprocess.CalledProcessError as e: #aqui é possivel incluir um send_error_email
        
        error_message = (
            f"Erro no dbt test:\n"
            f"Código de retorno: {e.returncode}\n"
            f"Saída padrão (stdout): {e.stdout}\n"
            f"Erro padrão (stderr): {e.stderr}"
        )
        logging.error(error_message)
       

def run_dbt_run():
    command = f"cd {dbt_project_path} && dbt run"
    logging.info(f"Executando: {command}")
    try:
        result = subprocess.run(
            command,
            capture_output=True,
            text=True,
            shell=True,
            check=True
        )
        logging.info(f"Saída padrão (stdout): {result.stdout}")
        logging.info(f"Erro padrão (stderr): {result.stderr}")
        logging.info("dbt run executado com sucesso.")
    
    except subprocess.CalledProcessError as e:
        error_message = (
            f"Erro no dbt run:\n"
            f"Código de retorno: {e.returncode}\n"
            f"Saída padrão (stdout): {e.stdout}\n"
            f"Erro padrão (stderr): {e.stderr}"
        )
        logging.error(error_message)
 
with DAG(
    "dbt_basic_pipeline",
    default_args={
        "owner": "airflow",
        "depends_on_past": False,
        "retries": 2,
    },
    description="Pipeline básico - dbt test e dbt run",
    schedule_interval='0 17 * * *',  # Executa diariamente às 17:00 UTC (14:00 BRT)
    # schedule_interval="*/10 * * * *",  # Para testes: roda a DAG a cada 10 minutos
    start_date=datetime(2025, 1, 25),
    end_date=datetime(2025, 1, 31),
    catchup=False,
) as dag:
    #task dbt test
    dbt_test = PythonOperator(
        task_id="dbt_test",
        python_callable=run_dbt_test,
    )
    #task dbt run
    dbt_run = PythonOperator(
        task_id="dbt_run",
        python_callable=run_dbt_run,
        # Mesmo que a task anterior falhe, esta será executada
        trigger_rule="all_done"
    )

    # executa a task do dbt test e depois a task do dbt run
    dbt_test >> dbt_run
