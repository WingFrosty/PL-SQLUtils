create or replace package body pkg_utils_number
as
-- ---------------------------------------------------------------------------------------------------------------------------------
-- Name         : PKG_UTILS_NUMBER
-- Author       : WingFrost
-- Description  : Utility functions for numbers
--
-- Date        Author                Description
-- ==========  ===================== ===============================================================================================
-- 25-09-2022  WingFrost             Initial Creation
-- ---------------------------------------------------------------------------------------------------------------------------------

function is_numeric(p_number in varchar2) return number
as 
-- Purpose : Check if a string is numeric. Returns 1 if TRUE and 0 if FALSE
--
-- Date        Author                Description
-- ==========  ===================== ===============================================================================================
-- 25-09-2022  WingFrost             Initial Creation

    v_number number;
begin
    v_number := to_number(p_number);
    return 1;
exception
    when others then
        return 0;
end is_number;

function convert_to_number(p_number in varchar2) return number
as 
-- Purpose : Convert a string to a number. Returns NULL if conversion fails
--
-- Date        Author                Description
-- ==========  ===================== ===============================================================================================
-- 25-09-2022  WingFrost             Initial Creation
    
    v_result number;
begin
    v_result := to_number(p_number);
    return v_result;
exception
    when others then
        return null;
end convert_to_number;

end pkg_utils_number;