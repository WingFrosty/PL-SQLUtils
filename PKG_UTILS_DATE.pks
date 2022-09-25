create or replace package pkg_utils_date
as
-- ---------------------------------------------------------------------------------------------------------------------------------
-- Name         : PKG_UTILS_DATE
-- Author       : WingFrost
-- Description  : Utility functions for date and time
-- ---------------------------------------------------------------------------------------------------------------------------------

c_first_day_current_month constant date := trunc(sysdate, 'mm');
c_last_day_current_month constant date := last_day(trunc(sysdate));
c_first_day_last_month constant date := trunc(add_months(sysdate, -1), 'mm');
c_last_day_last_month constant date := trunc(sysdate, 'mm') - 1;
c_first_day_current_week constant date := trunc(sysdate, 'iw');
c_last_day_current_week constant date := trunc(sysdate, 'iw') + 6;
c_first_day_last_week constant date := trunc(sysdate, 'iw') - 7;
c_last_day_last_week constant date := trunc(sysdate, 'iw') - 1;
c_first_day_current_quarter constant date := trunc(sysdate, 'q');
c_last_day_current_quarter constant date := trunc(add_months(sysdate, 3), 'q') - 1;
c_first_day_last_quarter constant date := trunc(add_months(sysdate, -3), 'q');
c_last_day_last_quarter constant date := trunc(sysdate, 'q') - 1;
c_first_day_current_semester constant date := greatest(trunc(sysdate, 'yyyy'), add_months(round(sysdate, 'yyyy'), -6));
c_last_day_current_semester constant date := greatest(trunc(add_months(sysdate, 6), 'yyyy'), add_months(round(add_months(sysdate, 6), 'yyyy'), -6)) - 1;
c_first_day_last_semester constant date := greatest(trunc(add_months(sysdate, -6), 'yyyy'), add_months(round(add_months(sysdate, -6), 'yyyy'), -6));
c_last_day_last_semester constant date := greatest(trunc(sysdate, 'yyyy'), add_months(round(sysdate, 'yyyy'), -6)) - 1;
c_first_day_current_year constant date := trunc(sysdate, 'yyyy');
c_last_day_current_year constant date := trunc(add_months(sysdate, 12), 'yyyy') - 1;
c_first_day_last_year constant date := trunc(add_months(sysdate, -12), 'yyyy');
c_last_day_last_year constant date := trunc(sysdate, 'yyyy') - 1;
c_first_day_last_month_year constant date := trunc(add_months(sysdate, -1), 'yyyy');

c_date_unit_year constant varchar2(10) := 'YEAR';
c_date_unit_month constant varchar2(10) := 'MONTH';
c_date_unit_day constant varchar2(10) := 'DAY';
c_date_unit_hour constant varchar2(10) := 'HOUR';
c_date_unit_minute constant varchar2(10) := 'MINUTE';
c_date_unit_second constant varchar2(10) := 'SECOND';

--Get year from given date
function get_year(p_date in date) return number;
--Get month number from given date
function get_month(p_date in date) return number;
--Get day number from given date
function get_day(p_date in date) return number;
--Get week of the year from given date
function get_week_year(p_date in date) return number;

--Check if a string corresponds to a date given a format mask. Returns 1 if TRUE and 0 if FALSE
function is_date(p_date in varchar2, p_format_mask in varchar2, p_nls_date_language in varchar2 default null) return number;
--Convert a string to a date given a format mask. Returns NULL if conversion fails
function convert_to_date(p_date in varchar2, p_format_mask in varchar2, p_nls_date_language in varchar2 default null) return date;

--Get number of last month based on given month's number
function get_last_month(p_date in date) return number;

--Get first day of month based on given date
function get_first_day_current_month(p_date in date default sysdate) return date;
--Get last day of month based on given date
function get_last_day_current_month(p_date in date default sysdate) return date;
--Get first day of previous month based on given date
function get_first_day_previous_month(p_date in date default sysdate) return date;
--Get last day of previous month based on given date
function get_last_day_previous_month(p_date in date default sysdate) return date;
--Get first day of next month based on given date
function get_first_day_next_month(p_date in date default sysdate) return date;
--Get last day of next month based on given date
function get_last_day_next_month(p_date in date default sysdate) return date;
--Get first day of week based on given date
function get_first_day_current_week(p_date in date default sysdate) return date;
--Get last day of week based on given date
function get_last_day_current_week(p_date in date default sysdate) return date;
--Get first day of previous week based on given date
function get_first_day_previous_week(p_date in date default sysdate) return date;
--Get last day of previous week based on given date
function get_last_day_previous_week(p_date in date default sysdate) return date;
--Get first day of next week based on given date
function get_first_day_next_week(p_date in date default sysdate) return date;
--Get last day of next week based on given date
function get_last_day_next_week(p_date in date default sysdate) return date;
--Get first day of quarter based on given date
function get_first_day_current_quarter(p_date in date default sysdate) return date;
--Get last day of quarter based on given date
function get_last_day_current_quarter(p_date in date default sysdate) return date;
--Get first day of previous quarter based on given date
function get_first_day_previous_quarter(p_date in date default sysdate) return date;
--Get last day of previous quarter based on given date
function get_last_day_previous_quarter(p_date in date default sysdate) return date;
--Get first day of next quarter based on given date
function get_first_day_next_quarter(p_date in date default sysdate) return date;
--Get last day of next quarter based on given date
function get_last_day_next_quarter(p_date in date default sysdate) return date;
--Get first day of semester based on given date
function get_first_day_current_semester(p_date in date default sysdate) return date,
--Get last day of semester based on given date
function get_last_day_current_semester(p_date in date default sysdate) return date;
--Get first day of previous semester based on given date
function get_first_day_previous_semeste(p_date in date default sysdate) return date;
--Get first day of previous semester based on given date
function get_last_day_previous_semester(p_date in date default sysdate) return date;
--Get first day of next semester based on given date
function get_first_day_next_semester(p_date in date default sysdate) return date;
--Get last day of next semester based on given date
function get_last_day_next_semester(p_date in date default sysdate) return date;
--Get first day of year based on given date
function get_first_day_current_year(p_date in date default sysdate) return date;
--Get last day of year based on given date
function get_last_day_current_year(p_date in date default sysdate) return date;
--Get first day of previous year based on given date
function get_first_day_previous_year(p_date in date default sysdate) return date;
--Get last day of previous year based on given date
function get_last_day_previous_year(p_date in date default sysdate) return date;
--Get first day of next year based on given date
function get_first_day_next_year(p_date in date default sysdate) return date;
--Get last day of next year based on given date
function get_last_day_next_year(p_date in date default sysdate) return date;

--Get number of days in month of given date
function get_days_in_month(p_date in date) return number;
--Get number of days in year of given date
function get_days_in_year(p_date in date) return number;

--Get number of date units between 2 given dates
function get_date_diff(p_date_unit varchar2, p_start_date date, p_end_date date) return number;
--Get number of complete years between 2 given dates
function get_years_between(p_start_date date, p_end_date date) return number;

--Format number of days into +DD HH24:MI:SS format
function fmt_time(p_days number) return varchar2;

end pkg_utils_date;