{% macro format_phone(column_name) %}
    regexp_replace({{ column_name }}, '[^0-9]', '', 'g')
{% endmacro %}