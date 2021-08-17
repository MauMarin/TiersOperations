def getFiscalMonth(month):
    fiscalMonth = 0
    if month > 4:
        fiscalMonth = month - 4
    else:
        fiscalMonth = month + 8
    fm = "P" + str(fiscalMonth)
    return fm

def getFiscalYear(year, month):
    fiscalYear = 0
    if month < 4:
        fiscalYear = year - 2000
    else:
        fiscalYear = year - 2000 + 1
    fy = "FY" + str(fiscalYear)
    return fy

def a():
    from datetime import date

    realDate = date.today()

    month = int(realDate.strftime("%m"))
    year = int(realDate.strftime("%Y"))

    fm = getFiscalMonth(month)
    fy = getFiscalYear(year, month)
    print(fm, fy)
