export class FixedCalendar extends Date {
    toFixedDate() {
        const months = [
            "January",
            "February",
            "March",
            "April",
            "May",
            "June",
            "Sol",
            "July",
            "August",
            "September",
            "October",
            "November",
            "December",
        ];
        const daysOfWeek = [
            "Sunday",
            "Monday",
            "Tuesday",
            "Wednesday",
            "Thursday",
            "Friday",
            "Saturday",
        ];
        const fd: any = { year: this.getFullYear() };
        const days = this.getDayOfYear();
        const month = Math.floor((days - 1) / 28);
        const date = days % 28;
        if (date == 0) {
            date = 28;
        }
        fd.day = daysOfWeek[(date - 1) % 7];
        const leapYear = isLeapYear(this.getFullYear());
        if (leapYear) {
            if (days == 169) {
                // special leap day case
                fd.monthName = "Leap Day";
                fd.date = 0;
                fd.isSpecial = true;
                return fd;
            } else if (days > 169) {
                //subtract leap day
                date = (days - 1) % 28;
                if (date == 0) {
                    date = 28;
                }
                month = Math.floor((days - 2) / 28);
            }
            if (days == 366) {
                fd.monthName = "Year Day";
                fd.date = 0;
                fd.isSpecial = true;
                return fd;
            }
        } else if (days == 365) {
            //day 365 is "year day"
            fd.monthName = "Year Day";
            fd.date = 0;
            fd.isSpecial = true;
            return fd;
        }
        fd.monthName = months[month];
        fd.date = date;
        return fd;
    }

    getDayOfYear() {
        const dayMs = 24 * 60 * 60 * 1000;
        const janFirst = new Date(this.getFullYear(), 0, 1);
        // 'date' is date at 2 am to ensure that daylight saving doesn't
        // screw up the calculation of ms since year start.
        const date = new Date(
            this.getFullYear(),
            this.getMonth(),
            this.getDate(),
            2
        );
        return Math.ceil((date - janFirst) / dayMs);
    }

    #isLeapYear(year) {
        return year % 4 == 0 && (year % 100 != 0 || year % 400 == 0);
    }
}

Date.prototype.toFixedDateString = function () {
    const fd = this.toFixedDate();
    if (fd.isSpecial) {
        return fd.monthName + " " + fd.year;
    }
    return fd.day + ", " + fd.monthName + " " + fd.date + ", " + fd.year;
};

ordinal = function (n) {
    end = n % 100;
    if (end > 10 && end < 14) {
        return n + "th";
    }
    end = end % 10;
    switch (end) {
        case 1:
            return n + "st";
            break;
        case 2:
            return n + "nd";
            break;
        case 3:
            return n + "rd";
            break;
        default:
            return n + "th";
    }
};
