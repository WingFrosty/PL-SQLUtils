create or replace package pkg_utils_number
as
-- ---------------------------------------------------------------------------------------------------------------------------------
-- Name         : PKG_UTILS_NUMBER
-- Author       : WingFrost
-- Description  : Utility functions for numbers
-- ---------------------------------------------------------------------------------------------------------------------------------

--Check if a string is numeric. Returns 1 if TRUE and 0 if FALSE
function is_numeric(p_number in varchar2) return number;
--Convert a string to a number. Returns NULL if conversion fails
function convert_to_number(p_number in varchar2) return number;

end pkg_utils_number;