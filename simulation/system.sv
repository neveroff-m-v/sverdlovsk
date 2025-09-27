/// Пакет предоставляющий функционал операционной системы
package system;

/// Системные дата и время
class datetime;
    
    /// Год
    static string year;

    /// Месяц
    static string month;

    /// День
    static string day;

    /// Часы
    static string hour;

    /// Минуты
    static string minute;

    /// Секунды
    static string second;
    
    function new();
    endfunction

    /// Вернуть строку в обычном формате YYYY-MM-DD-HH-MM-SS
    static function string get();
        string result;
        
        compute();
        $sformat(result, "%s-%s-%s-%s-%s-%s", year, month, day, hour, minute, second);
        return result;
    endfunction
    
    /// Вернуть строку в коротком формате YYYYMMDDHHMMSS
    static function string get_short();
        string result;
        
        compute();
        $sformat(result, "%s%s%s%s%s%s", year, month, day, hour, minute, second);
        return result;
    endfunction
    
    /// Вычислить дату и время (результат будет записан в статические поля)
    static function void compute();
        int descriptor;
        string result;
       
        $system("echo %date% %time% >> systemtime.txt");
        descriptor = $fopen("systemtime.txt", "r");
        $fgets(result, descriptor);
        $fclose(descriptor);
        $system("del systemtime.txt");
        
        day = result.substr(0, 1);
        month = result.substr(3, 4);
        year = result.substr(6, 9);
        hour = result.substr(11, 12);
        minute = result.substr(14, 15);
        second = result.substr(17, 18);
    endfunction
endclass

endpackage 
