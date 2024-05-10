from hwc0y5uew53vulouvqc2cg_.utils import *

def Model_0():
    from datetime import timedelta
    from airflow.operators.bash import BashOperator
    dbt_props_cmd = ""

    if "run_profile":
        dbt_props_cmd = " --profile run_profile"

    if "fct_orders":
        dbt_props_cmd = dbt_props_cmd + " -m " + "fct_orders"

    return BashOperator(
        task_id = "Model_0",
        bash_command = f'''$PROPHECY_HOME/run_dbt.sh "{"; ".join(["dbt run" + dbt_props_cmd, "dbt test" + dbt_props_cmd])}"''',
        env = {
          "DBT_PROFILE_SECRET": "9e7IiTuF3wbBZ6Krzk8XS", 
          "GIT_TOKEN_SECRET": "_Pi8fCjEAd6nM5JNZVneHg_", 
          "GIT_ENTITY": "branch", 
          "GIT_ENTITY_VALUE": "rajat2app", 
          "GIT_SSH_URL": "https://github.com/SimpleDataLabsInc/dbt-tpch", 
          "GIT_SUB_PATH": ""
        },
        append_env = True,
    )
