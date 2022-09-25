create or replace package body pkg_utils_date
as
-- ---------------------------------------------------------------------------------------------------------------------------------
-- Name         : PKG_UTILS_DATE
-- Author       : WingFrost
-- Description  : Utility functions for date and time
--
-- Date        Author                Description
-- ==========  ===================== ===============================================================================================
-- 25-09-2022  WingFrost             Initial Creation
-- ---------------------------------------------------------------------------------------------------------------------------------

function get_year(p_date in date) return number
as 
-- Purpose : Get year from given date
--
-- Date        Author                Description
-- ==========  ===================== ===============================================================================================
-- 25-09-2022  WingFrost             Initial Creation
    
    v_result number;
begin
    v_result := to_number(to_char(p_date, 'yyyy'));

    return v_result;
end get_year;

function get_month(p_date in date) return number
as 
-- Purpose : Get month number from given date
--
-- Date        Author                Description
-- ==========  ===================== ===============================================================================================
-- 25-09-2022  WingFrost             Initial Creation

    v_result number;
begin
    v_result := to_number(to_char(p_date, 'mm'));

    return v_result;
end get_month;

function get_day(p_date in date) return number
as 
-- Purpose : Get day number from given date
--
-- Date        Author                Description
-- ==========  ===================== ===============================================================================================
-- 25-09-2022  WingFrost             Initial Creation

    v_result number;
begin
    v_result := to_number(to_char(p_date, 'dd'));

    return v_result;
end get_day;

function get_week_year(p_date in date) return number
as
-- Purpose : Get week of the year from given date
-- Rules :
--      - A week starts on a Monday and ends on a Sunday
--      - The first week of January will always be nr. 1 and the last week of December will always be numbered after the week before that
--      - If the year starts in a day other than Monday, that week will have 2 numbers, one number for the days in December and the
--        other for the days in January
--
-- Date        Author                Description
-- ==========  ===================== ===============================================================================================
-- 25-09-2022  WingFrost             Initial Creation

    v_result number;
begin
    v_result := (case
        when (mod(to_char(to_date(to_char(p_date,'YYYY') || '0101', 'yyyymmdd'), 'd') - 2 + 7, 7) - mod(to_char(p_date, 'd') - 2 + 7, 7)) > 0
            then trunc((to_char(p_date, 'ddd') - 1) / 7) + 1 + 1
        else trunc((to_char(p_date, 'ddd') - 1) / 7) + 1
    end);

    return v_result;
end get_week_year;

function is_date(p_date in varchar2, p_format_mask in varchar2, p_nls_date_language in varchar2 default null) return number
as 
-- Purpose : Check if a string corresponds to a date given a format mask. Returns 1 if TRUE and 0 if FALSE
--
-- Date        Author                Description
-- ==========  ===================== ===============================================================================================
-- 25-09-2022  WingFrost             Initial Creation

    v_date date;
begin
    if (p_nls_date_language is null) then
        v_date := to_date(p_date, p_format_mask);
    else
        v_date := to_date(p_date, p_format_mask, p_nls_date_language);
    end if;

    return 1;
exception
    when others then
        return 0;
end is_date;

function convert_to_date(p_date in varchar2, p_format_mask in varchar2, p_nls_date_language in varchar2 default null) return date
as 
-- Purpose : Convert a string to a date given a format mask. Returns NULL if conversion fails
--
-- Date        Author                Description
-- ==========  ===================== ===============================================================================================
-- 25-09-2022  WingFrost             Initial Creation

    v_result date;
begin
    if (p_nls_date_language is null) then
        v_result := to_date(p_date, p_format_mask);
    else
        v_result := to_date(p_date, p_format_mask, p_nls_date_language);
    end if;

    return v_result;
exception
    when others then
        return null;
end convert_to_date;

function get_last_month(p_month in number) return number
as
-- Purpose : Get number of last month based on given month's number
--
-- Date        Author                Description
-- ==========  ===================== ===============================================================================================
-- 25-09-2022  WingFrost             Initial Creation

    v_result number;
begin
    v_result := mod(p_month - 2 + 12 , 12) + 1;

    return v_result;
end get_last_month;

function get_first_day_current_month(p_date in date default sysdate) return date
as
-- Purpose : Get first day of month based on given date
--
-- Date        Author                Description
-- ==========  ===================== ===============================================================================================
-- 25-09-2022  WingFrost             Initial Creation

    v_result date;
begin
    v_result := trunc(p_date, 'mm');

    return v_result;
end;

function get_last_day_current_month(p_date in date default sysdate) return date
as
-- Purpose : Get last day of month based on given date
--
-- Date        Author                Description
-- ==========  ===================== ===============================================================================================
-- 25-09-2022  WingFrost             Initial Creation

    v_result date;
begin
    v_result := last_day(trunc(p_date));

    return v_result;
end;

function get_first_day_previous_month(p_date in date default sysdate) return date
as
-- Purpose : Get first day of previous month based on given date
--
-- Date        Author                Description
-- ==========  ===================== ===============================================================================================
-- 25-09-2022  WingFrost             Initial Creation

    v_result date;
begin
    v_result := trunc(add_months(p_date, -1), 'mm');

    return v_result;
end;

function get_last_day_previous_month(p_date in date default sysdate) return date
as
-- Purpose : Get last day of previous month based on given date
--
-- Date        Author                Description
-- ==========  ===================== ===============================================================================================
-- 25-09-2022  WingFrost             Initial Creation

    v_result date;
begin
    v_result := trunc(p_date, 'mm') - 1;

    return v_result;
end;

function get_first_day_next_month(p_date in date default sysdate) return date
as
-- Purpose : Get first day of next month based on given date
--
-- Date        Author                Description
-- ==========  ===================== ===============================================================================================
-- 25-09-2022  WingFrost             Initial Creation

    v_result date;
begin
    v_result := last_day(trunc(p_date)) + 1;

    return v_result;
end;

function get_last_day_next_month(p_date in date default sysdate) return date
as
-- Purpose : Get last day of next month based on given date
--
-- Date        Author                Description
-- ==========  ===================== ===============================================================================================
-- 25-09-2022  WingFrost             Initial Creation

    v_result date;
begin
    v_result := last_day(add_months(trunc(p_date), 1));

    return v_result;
end;

function get_first_day_current_week(p_date in date default sysdate) return date
as
-- Purpose : Get first day of week based on given date
--
-- Date        Author                Description
-- ==========  ===================== ===============================================================================================
-- 25-09-2022  WingFrost             Initial Creation

    v_result date;
begin
    v_result := trunc(p_date, 'iw');

    return v_result;
end;

function get_last_day_current_week(p_date in date default sysdate) return date
as
-- Purpose : Get last day of week based on given date
--
-- Date        Author                Description
-- ==========  ===================== ===============================================================================================
-- 25-09-2022  WingFrost             Initial Creation

    v_result date;
begin
    v_result := trunc(p_date, 'iw') + 6;

    return v_result;
end;

function get_first_day_previous_week(p_date in date default sysdate) return date
as
-- Purpose : Get first day of previous week based on given date
--
-- Date        Author                Description
-- ==========  ===================== ===============================================================================================
-- 25-09-2022  WingFrost             Initial Creation

    v_result date;
begin
    v_result := trunc(p_date, 'iw') - 7;

    return v_result;
end;

function get_last_day_previous_week(p_date in date default sysdate) return date
as
-- Purpose : Get last day of previous week based on given date
--
-- Date        Author                Description
-- ==========  ===================== ===============================================================================================
-- 25-09-2022  WingFrost             Initial Creation

    v_result date;
begin
    v_result := trunc(p_date, 'iw') - 1;

    return v_result;
end;

function get_first_day_next_week(p_date in date default sysdate) return date
as
-- Purpose : Get first day of next week based on given date
--
-- Date        Author                Description
-- ==========  ===================== ===============================================================================================
-- 25-09-2022  WingFrost             Initial Creation

    v_result date;
begin
    v_result := trunc(p_date, 'iw') + 7;

    return v_result;
end;

function get_last_day_next_week(p_date in date default sysdate) return date
as
-- Purpose : Get last day of next week based on given date
--
-- Date        Author                Description
-- ==========  ===================== ===============================================================================================
-- 25-09-2022  WingFrost             Initial Creation

    v_result date;
begin
    v_result := trunc(p_date, 'iw') + 7 + 6;

    return v_result;
end;

function get_first_day_current_quarter(p_date in date default sysdate) return date
as
-- Purpose : Get first day of quarter based on given date
--
-- Date        Author                Description
-- ==========  ===================== ===============================================================================================
-- 25-09-2022  WingFrost             Initial Creation

    v_result date;
begin
    v_result := trunc(p_date, 'q');

    return v_result;
end;

function get_last_day_current_quarter(p_date in date default sysdate) return date
as
-- Purpose : Get last day of quarter based on given date
--
-- Date        Author                Description
-- ==========  ===================== ===============================================================================================
-- 25-09-2022  WingFrost             Initial Creation

    v_result date;
begin
    v_result := trunc(add_months(p_date, 3), 'q') - 1;

    return v_result;
end;

function get_first_day_previous_quarter(p_date in date default sysdate) return date
as
-- Purpose : Get first day of previous quarter based on given date
--
-- Date        Author                Description
-- ==========  ===================== ===============================================================================================
-- 25-09-2022  WingFrost             Initial Creation

    v_result date;
begin
    v_result := trunc(add_months(p_date, -3), 'q');

    return v_result;
end;

function get_last_day_previous_quarter(p_date in date default sysdate) return date
as
-- Purpose : Get last day of previous quarter based on given date
--
-- Date        Author                Description
-- ==========  ===================== ===============================================================================================
-- 25-09-2022  WingFrost             Initial Creation

    v_result date;
begin
    v_result := trunc(p_date, 'q') - 1;

    return v_result;
end;

function get_first_day_next_quarter(p_date in date default sysdate) return date
as
-- Purpose : Get first day of next quarter based on given date
--
-- Date        Author                Description
-- ==========  ===================== ===============================================================================================
-- 25-09-2022  WingFrost             Initial Creation

    v_result date;
begin
    v_result := trunc(add_months(p_date, 3), 'q');

    return v_result;
end;

function get_last_day_next_quarter(p_date in date default sysdate) return date
as
-- Purpose : Get last day of next quarter based on given date
--
-- Date        Author                Description
-- ==========  ===================== ===============================================================================================
-- 25-09-2022  WingFrost             Initial Creation

    v_result date;
begin
    v_result := trunc(add_months(p_date, 6), 'q') - 1;

    return v_result;
end;

function get_first_day_current_semester(p_date in date default sysdate) return date
as
-- Purpose : Get first day of semester based on given date
--
-- Date        Author                Description
-- ==========  ===================== ===============================================================================================
-- 25-09-2022  WingFrost             Initial Creation

    v_result date;
begin
    v_result := greatest(trunc(p_date, 'yyyy'), add_months(round(p_date, 'yyyy'), -6));

    return v_result;
end;

function get_last_day_current_semester(p_date in date default sysdate) return date
as
-- Purpose : Get last day of semester based on given date
--
-- Date        Author                Description
-- ==========  ===================== ===============================================================================================
-- 25-09-2022  WingFrost             Initial Creation

    v_result date;
begin
    v_result := greatest(trunc(add_months(p_date, 6), 'yyyy'), add_months(round(add_months(p_date, 6), 'yyyy'), -6)) - 1;

    return v_result;
end;

function get_first_day_previous_semeste(p_date in date default sysdate) return date
as
-- Purpose : Get first day of previous semester based on given date
--
-- Date        Author                Description
-- ==========  ===================== ===============================================================================================
-- 25-09-2022  WingFrost             Initial Creation

    v_result date;
begin
    v_result := greatest(trunc(add_months(p_date, -6), 'yyyy'), add_months(round(add_months(p_date, -6), 'yyyy'), -6));

    return v_result;
end;

function get_last_day_previous_semester(p_date in date default sysdate) return date
as
-- Purpose : Get first day of previous semester based on given date
--
-- Date        Author                Description
-- ==========  ===================== ===============================================================================================
-- 25-09-2022  WingFrost             Initial Creation

    v_result date;
begin
    v_result := greatest(trunc(p_date, 'yyyy'), add_months(round(p_date, 'yyyy'), -6)) - 1;

    return v_result;
end;

function get_first_day_next_semester(p_date in date default sysdate) return date
as
-- Purpose : Get first day of next semester based on given date
--
-- Date        Author                Description
-- ==========  ===================== ===============================================================================================
-- 25-09-2022  WingFrost             Initial Creation

    v_result date;
begin
    v_result := greatest(trunc(add_months(p_date, 6), 'yyyy'), add_months(round(add_months(p_date, 6), 'yyyy'), -6));

    return v_result;
end;

function get_last_day_next_semester(p_date in date default sysdate) return date
as
-- Purpose : Get last day of next semester based on given date
--
-- Date        Author                Description
-- ==========  ===================== ===============================================================================================
-- 25-09-2022  WingFrost             Initial Creation

    v_result date;
begin
    v_result := greatest(trunc(add_months(p_date, 12), 'yyyy'), add_months(round(add_months(p_date, 12), 'yyyy'), -6)) - 1;

    return v_result;
end;

function get_first_day_current_year(p_date in date default sysdate) return date
as
-- Purpose : Get first day of year based on given date
--
-- Date        Author                Description
-- ==========  ===================== ===============================================================================================
-- 25-09-2022  WingFrost             Initial Creation

    v_result date;
begin
    v_result := trunc(p_date, 'yyyy');

    return v_result;
end;

function get_last_day_current_year(p_date in date default sysdate) return date
as
-- Purpose : Get last day of year based on given date
--
-- Date        Author                Description
-- ==========  ===================== ===============================================================================================
-- 25-09-2022  WingFrost             Initial Creation

    v_result date;
begin
    v_result := trunc(add_months(p_date, 12), 'yyyy') - 1;

    return v_result;
end;

function get_first_day_previous_year(p_date in date default sysdate) return date
as
-- Purpose : Get first day of previous year based on given date
--
-- Date        Author                Description
-- ==========  ===================== ===============================================================================================
-- 25-09-2022  WingFrost             Initial Creation

    v_result date;
begin
    v_result := trunc(add_months(p_date, -12), 'yyyy');

    return v_result;
end;

function get_last_day_previous_year(p_date in date default sysdate) return date
as
-- Purpose : Get last day of previous year based on given date
--
-- Date        Author                Description
-- ==========  ===================== ===============================================================================================
-- 25-09-2022  WingFrost             Initial Creation

    v_result date;
begin
    v_result := trunc(p_date, 'yyyy') - 1;

    return v_result;
end;

function get_first_day_next_year(p_date in date default sysdate) return date
as
-- Purpose : Get first day of next year based on given date
--
-- Date        Author                Description
-- ==========  ===================== ===============================================================================================
-- 25-09-2022  WingFrost             Initial Creation

    v_result date;
begin
    v_result := trunc(add_months(p_date, 12), 'yyyy');

    return v_result;
end;

function get_last_day_next_year(p_date in date default sysdate) return date
as
-- Purpose : Get last day of next year based on given date
--
-- Date        Author                Description
-- ==========  ===================== ===============================================================================================
-- 25-09-2022  WingFrost             Initial Creation

    v_result date;
begin
    v_result := trunc(add_months(p_date, 24), 'yyyy') - 1;

    return v_result;
end;

function get_days_in_month(p_date in date) return number
as
-- Purpose : Get number of days in month of given date
--
-- Date        Author                Description
-- ==========  ===================== ===============================================================================================
-- 25-09-2022  WingFrost             Initial Creation

    v_result number;
begin
    v_result := trunc(p_date, 'mm') - last_day(trunc(p_date)) + 1;

    return v_result;
exception
    when others then
        return null;
end get_days_in_month;

function get_days_in_year(p_date in date) return number
as
-- Purpose : Get number of days in year of given date
--
-- Date        Author                Description
-- ==========  ===================== ===============================================================================================
-- 25-09-2022  WingFrost             Initial Creation

    v_result number;
begin
    v_result := (trunc(add_months(p_date, 12), 'yyyy') - 1) - trunc(p_date, 'yyyy') + 1

    return v_result;
exception
    when others then
        return null;
end get_days_in_year;

function get_date_diff(p_date_unit varchar2, p_start_date date, p_end_date date) return number
as
-- Purpose : Get number of date units between 2 given dates
--
-- Date        Author                Description
-- ==========  ===================== ===============================================================================================
-- 25-09-2022  WingFrost             Initial Creation

    v_result number;
    v_date_unit varchar2(4000) := upper(p_date_unit);
begin
    if (v_date_unit = c_date_unit_year) then
        v_result := months_between(p_end_date, p_start_date) / 12;
    elsif (v_date_unit = c_date_unit_month) then
        v_result := months_between(p_end_date, p_start_date);
    elsif (v_date_unit = c_date_unit_day) then
        v_result := p_end_date - p_start_date;
    elsif (v_date_unit = c_date_unit_hour) then
        v_result := (p_end_date - p_start_date) * 24;
    elsif (v_date_unit = c_date_unit_minute) then
        v_result := (p_end_date - p_start_date) * 24 * 60;
    elsif (v_date_unit = c_date_unit_second) then
        v_result := (p_end_date - p_start_date) * 24 * 60 * 60;
    else
        null;
    end if;

    return v_result;
end get_date_diff;

function get_years_between(p_start_date date, p_end_date date) return number
as
-- Purpose : Get number of complete years between 2 given dates
--
-- Date        Author                Description
-- ==========  ===================== ===============================================================================================
-- 25-09-2022  WingFrost             Initial Creation

    v_result number;
begin
    v_result := trunc(get_date_diff(c_date_unit_year, p_start_date, p_end_date));

    return v_result;
end get_years_between;

function fmt_time(p_days number) return varchar2
as
-- Purpose : Format number of days into +DD HH24:MI:SS format
--
-- Date        Author                Description
-- ==========  ===================== ===============================================================================================
-- 25-09-2022  WingFrost             Initial Creation

    v_result varchar2(4000);
    v_sign varchar(1);
    v_days number;
    v_hours number;
    v_minutes number;
    v_seconds number;
begin
    if (p_days is null) then
        return null;
    end if;    

    if (p_days < 0) then
        v_sign := '-';
    else
        v_sign := '+';
    end if;

    v_days := abs(p_days);
    v_hours := (v_days - trunc(v_days)) * 24;
    v_minutes := (v_hours - trunc(v_hours)) * 60;
    v_seconds := (v_minutes - trunc(v_minutes)) * 60;

    if (abs(p_days) >= 1) then
        v_result := v_sign || to_char(trunc(v_days)) || ' ' || lpad(to_char(trunc(v_hours)), 2, '0') || ':' || lpad(to_char(trunc(v_minutes)), 2, '0') || ':' || lpad(to_char(trunc(v_seconds)), 2, '0');
    else
        v_result := v_sign || lpad(to_char(trunc(v_hours)), 2, '0') || ':' || lpad(to_char(trunc(v_minutes)), 2, '0') || ':' || lpad(to_char(trunc(v_seconds)), 2, '0');
    end if;

    return v_result;
end fmt_time;

end pkg_utils_date;