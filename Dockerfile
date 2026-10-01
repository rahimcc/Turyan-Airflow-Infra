FROM apache/airflow:3.3.1-python3.12

COPY ./requirements.txt /requirements.txt

COPY --chown=airflow:root config/airflow.cfg /opt/airflow/airflow.cfg


USER root
RUN python -m venv /opt/dbt_venv && \
    /opt/dbt_venv/bin/pip install --no-cache-dir dbt-core==1.12.4 dbt-clickhouse openlineage-dbt

USER airflow
RUN pip install --no-cache-dir -r /requirements.txt\
                --constraint https://raw.githubusercontent.com/apache/airflow/constraints-3.3.1/constraints-3.12.txt

        