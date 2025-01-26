from airflow import DAG
from airflow.models import Variable
from airflow.operators.python import PythonOperator
from datetime import datetime
import subprocess

# Recupera o caminho do projeto dbt da variável do Airflow
dbt_project_path = Variable.get("dbt_project_path")

# Função para executar o comando dbt test
def run_dbt_test():
    try:
        print(f"Executando: cd {dbt_project_path} && dbt test")
        result = subprocess.run(
            f"cd {dbt_project_path} && dbt test",
            capture_output=True,
            text=True,
            shell=True,
        )
        print(f"Saída padrão (stdout): {result.stdout}")
        print(f"Erro padrão (stderr): {result.stderr}")
    except Exception as e:
        print(f"Erro ao executar dbt test: {str(e)}")

# Função para executar o comando dbt run
def run_dbt_run():
    try:
        print(f"Executando: cd {dbt_project_path} && dbt run")
        result = subprocess.run(
            f"cd {dbt_project_path} && dbt run",
            capture_output=True,
            text=True,
            shell=True,
        )
        print(f"Saída padrão (stdout): {result.stdout}")
        print(f"Erro padrão (stderr): {result.stderr}")
    except Exception as e:
        print(f"Erro ao executar dbt run: {str(e)}")

# Definição da DAG
with DAG(
    "dbt_basic_pipeline",
    default_args={
        "owner": "airflow",
        "depends_on_past": False,
        "retries": 0,
    },
    
    description="Pipeline básico com dbt test e dbt run usando variável",
    schedule_interval='10,20,30 16 * * *',  # CRON para 16:10, 16:20, 16:30
    start_date=datetime(2025, 1, 26),      
    end_date=datetime(2025, 1, 31),
    catchup=False,

) as dag:

    # Task para rodar dbt test
    dbt_test = PythonOperator(
        task_id="dbt_test",
        python_callable=run_dbt_test,
    )

    # Task para rodar dbt run
    dbt_run = PythonOperator(
        task_id="dbt_run",
        python_callable=run_dbt_run,
    )

    # Ordem de execução
    dbt_test >> dbt_run
