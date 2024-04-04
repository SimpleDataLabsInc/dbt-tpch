{% macro surrogate_key() %}
{% set fields = [] %}

{%- for field in varargs -%}

    {% set _ = fields.append(
        "coalesce(cast(" ~ field ~ " as " ~ dbt.type_string() ~ "), '')"
    ) %}

    {% if not loop.last %}
        {% set _ = fields.append("'-'") %}
    {% endif %}

{%- endfor -%}

{{dbt.hash(dbt.concat(fields))}}
{% endmacro %}

 