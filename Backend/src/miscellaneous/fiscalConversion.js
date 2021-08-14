
var fiscal = {
    getMonth: function getFiscalMonth(month){
        var fiscalMonth = 0;
        if(month > 4) fiscalMonth = month - 4;
        else fiscalMonth = month + 8;
        const fm = `P${fiscalMonth}`;
        return fm;
    },
    
    getYear: function getFiscalYear(year, month){
        var fiscalYear = 0;
        if(month < 4) fiscalYear = year - 2000;
        else fiscalYear = year - 2000 + 1;
        const fy = `FY${fiscalYear}`;
        return fy;
    }
}



module.exports = fiscal;