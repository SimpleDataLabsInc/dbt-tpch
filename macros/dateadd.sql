{% macro dateadd(datepart, interval, from_date_or_timestamp) %}
dateadd(
        {{ datepart }},
        {{ interval }},
        {{ from_date_or_timestamp }}
)
{% endmacro %}

 