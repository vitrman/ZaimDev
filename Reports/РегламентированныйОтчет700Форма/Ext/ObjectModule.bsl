﻿Функция ТаблицаФормОтчета() Экспорт
	
	ОписаниеТиповСтрока = Новый ОписаниеТипов("Строка", , Новый КвалификаторыСтроки(254));
	
	МассивТипов = Новый Массив;
	МассивТипов.Добавить(Тип("Дата"));
	ОписаниеТиповДата = Новый ОписаниеТипов(МассивТипов, , Новый КвалификаторыДаты(ЧастиДаты.Дата));
	
	ТаблицаФормОтчета = Новый ТаблицаЗначений;
	ТаблицаФормОтчета.Колонки.Добавить("ФормаОтчета",        ОписаниеТиповСтрока);
	ТаблицаФормОтчета.Колонки.Добавить("ОписаниеОтчета",     ОписаниеТиповСтрока, "Утверждена",  20);
	ТаблицаФормОтчета.Колонки.Добавить("ДатаНачалоДействия", ОписаниеТиповДата,   "Действует с", 5);
	ТаблицаФормОтчета.Колонки.Добавить("ДатаКонецДействия",  ОписаниеТиповДата,   "         по", 5);
		
	НоваяФорма = ТаблицаФормОтчета.Добавить();
	НоваяФорма.ФормаОтчета        = "Форма7002014Кв4";
	НоваяФорма.ОписаниеОтчета     = "Декларация по налогу на транспортные средства, земельному налогу и налогу на имущество. Версия шаблона ФНО для ИС СОНО: 700.00.v18.r102 от 31.12.2013г."; 
	НоваяФорма.ДатаНачалоДействия = '20140101';
	НоваяФорма.ДатаКонецДействия  = '20141231';
	
	НоваяФорма = ТаблицаФормОтчета.Добавить();
	НоваяФорма.ФормаОтчета        = "Форма7002015Кв4";
	НоваяФорма.ОписаниеОтчета     = "Декларация по налогу на транспортные средства, земельному налогу и налогу на имущество. Версия шаблона ФНО для ИС СОНО: 700.00.v19.r113 от 24.03.2016г."; 
	НоваяФорма.ДатаНачалоДействия = '20150101';
	НоваяФорма.ДатаКонецДействия  = '20151231';
	
	НоваяФорма = ТаблицаФормОтчета.Добавить();
	НоваяФорма.ФормаОтчета        = "Форма7002016Кв4";
	НоваяФорма.ОписаниеОтчета     = "Декларация по налогу на транспортные средства, земельному налогу и налогу на имущество. Версия шаблона ФНО для ИС СОНО: 700.00.v20.r115 от 13.08.2016г."; 
	НоваяФорма.ДатаНачалоДействия = '20160101';
	НоваяФорма.ДатаКонецДействия  = '20161231';
	
	НоваяФорма = ТаблицаФормОтчета.Добавить();
	НоваяФорма.ФормаОтчета        = "Форма7002017Кв4";
	НоваяФорма.ОписаниеОтчета     = "Декларация по налогу на транспортные средства, земельному налогу и налогу на имущество. Версия шаблона ФНО для ИС СОНО: 700.00.v20.r116 от 25.12.2016г."; 
	НоваяФорма.ДатаНачалоДействия = '20170101';
	НоваяФорма.ДатаКонецДействия  = '20171231';
	
	НоваяФорма = ТаблицаФормОтчета.Добавить();
	НоваяФорма.ФормаОтчета        = "Форма7002018Кв4";
	НоваяФорма.ОписаниеОтчета     = "Декларация по налогу на транспортные средства, земельному налогу и налогу на имущество. Версия шаблона ФНО для ИС СОНО: 700.00.v22.r125 от 06.05.2019г."; 
	НоваяФорма.ДатаНачалоДействия = '20180101';
	НоваяФорма.ДатаКонецДействия  = '20181231';
	
	НоваяФорма = ТаблицаФормОтчета.Добавить();
	НоваяФорма.ФормаОтчета        = "Форма7002019Кв4";
	НоваяФорма.ОписаниеОтчета     = "Декларация по налогу на транспортные средства, земельному налогу и налогу на имущество. Версия шаблона ФНО для ИС СОНО: 700.00.v22.r129 от 19.06.2020г."; 
	НоваяФорма.ДатаНачалоДействия = '20190101';
	НоваяФорма.ДатаКонецДействия  = '20191231';
	
	НоваяФорма = ТаблицаФормОтчета.Добавить();
	НоваяФорма.ФормаОтчета        = "Форма7002020Кв4";
	НоваяФорма.ОписаниеОтчета     = "Декларация по налогу на транспортные средства, земельному налогу и налогу на имущество. Версия шаблона ФНО для ИС СОНО: 700.00.v24.r131 от 21.12.2020г."; 
	НоваяФорма.ДатаНачалоДействия = '20200101';
	НоваяФорма.ДатаКонецДействия  = '20201231';
	
	НоваяФорма = ТаблицаФормОтчета.Добавить();
	НоваяФорма.ФормаОтчета        = "Форма7002021Кв1";
	НоваяФорма.ОписаниеОтчета     = "Декларация по налогу на транспортные средства, земельному налогу и налогу на имущество. Версия шаблона ФНО для ИС СОНО: 700.00.v24.r132 от 23.12.2021г."; 
	НоваяФорма.ДатаНачалоДействия = '20210101';
	НоваяФорма.ДатаКонецДействия  = '20211231'; 
	
	НоваяФорма = ТаблицаФормОтчета.Добавить();
	НоваяФорма.ФормаОтчета        = "Форма7002022Кв1";
	НоваяФорма.ОписаниеОтчета     = "Декларация по налогу на транспортные средства, земельному налогу и налогу на имущество. Версия шаблона ФНО для ИС СОНО: 700.00.v24.r133 от 22.12.2022г."; 
	НоваяФорма.ДатаНачалоДействия = '20220101';
	НоваяФорма.ДатаКонецДействия  = '20221231'; 
	
	НоваяФорма = ТаблицаФормОтчета.Добавить();
	НоваяФорма.ФормаОтчета        = "Форма7002023Кв1";
	НоваяФорма.ОписаниеОтчета     = "Декларация по налогу на транспортные средства, земельному налогу и налогу на имущество. Версия шаблона ФНО для ИС СОНО: 700.00.v25.r135 от 26.12.2023г."; 
	НоваяФорма.ДатаНачалоДействия = '20230101';
	НоваяФорма.ДатаКонецДействия  = РегламентированнаяОтчетностьКлиентСервер.ПустоеЗначениеТипа(Тип("Дата"));
	
	Возврат ТаблицаФормОтчета;
	
КонецФункции

Функция ПолучитьПараметрыИсполненияОтчета() Экспорт
	
	Возврат Новый Структура("ИспользоватьПередКомпоновкойМакета,
							|ИспользоватьПриВыводеЗаголовка,
							|ИспользоватьВнешниеНаборыДанных,
							|ИспользоватьПослеВыводаРезультата,
							|ИспользоватьДанныеРасшифровки,
							|ИспользоватьРасширенныеПараметрыРасшифровки",
							Истина, Истина, Истина, Ложь, Ложь, Ложь);
							
КонецФункции

Функция ПолучитьВнешниеНаборыДанных(ПараметрыОтчета, МакетКомпоновки) Экспорт
		
	Возврат Новый Структура("ТаблицаРасшифровкиНалогаНаТранспорт", ПараметрыОтчета.ТаблицаРасшифровкиНалогаНаТранспорт);
	
КонецФункции

Процедура ПередКомпоновкойМакета(ПараметрыОтчета, СхемаКомпоновкиДанных, КомпоновщикНастроек) Экспорт
		
	КомпоновщикНастроек.Настройки.Структура.Очистить();
	
	БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "НачалоПериода", НачалоДня(ПараметрыОтчета.НачалоПериода));
	БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "КонецПериода" , КонецДня(ПараметрыОтчета.КонецПериода));
	
	БухгалтерскиеОтчетыКлиентСервер.ДобавитьВыбранноеПоле(КомпоновщикНастроек, "СуммаНалога");
			
	Структура = КомпоновщикНастроек.Настройки.Структура.Добавить(Тип("ГруппировкаКомпоновкиДанных"));
	Структура.Имя = "Группировка";
		
	ПолеГруппировки = Структура.ПоляГруппировки.Элементы.Добавить(Тип("ПолеГруппировкиКомпоновкиДанных"));
	ПолеГруппировки.Использование  = Истина;
	ПолеГруппировки.Поле           = Новый ПолеКомпоновкиДанных("Организация");
	ПолеГруппировки.ТипГруппировки = ТипГруппировкиКомпоновкиДанных.Элементы;
	Структура.Выбор.Элементы.Добавить(Тип("АвтоВыбранноеПолеКомпоновкиДанных"));
	Структура.Порядок.Элементы.Добавить(Тип("АвтоЭлементПорядкаКомпоновкиДанных"));
	
	Структура = Структура.Структура.Добавить(Тип("ГруппировкаКомпоновкиДанных"));
	
	ПолеГруппировки = Структура.ПоляГруппировки.Элементы.Добавить(Тип("ПолеГруппировкиКомпоновкиДанных"));
	ПолеГруппировки.Использование  = Истина;
	ПолеГруппировки.Поле           = Новый ПолеКомпоновкиДанных("ВидТранспортногоСредства");
	ПолеГруппировки.ТипГруппировки = ТипГруппировкиКомпоновкиДанных.Элементы;
	Структура.Выбор.Элементы.Добавить(Тип("АвтоВыбранноеПолеКомпоновкиДанных"));
	Структура.Порядок.Элементы.Добавить(Тип("АвтоЭлементПорядкаКомпоновкиДанных")); 
	
	Структура = Структура.Структура.Добавить(Тип("ГруппировкаКомпоновкиДанных"));
	
	ПолеГруппировки = Структура.ПоляГруппировки.Элементы.Добавить(Тип("ПолеГруппировкиКомпоновкиДанных"));
	ПолеГруппировки.Использование  = Истина;
	ПолеГруппировки.Поле           = Новый ПолеКомпоновкиДанных("ГрафаОтчета");
	ПолеГруппировки.ТипГруппировки = ТипГруппировкиКомпоновкиДанных.Элементы;
	Структура.Выбор.Элементы.Добавить(Тип("АвтоВыбранноеПолеКомпоновкиДанных"));
	Структура.Порядок.Элементы.Добавить(Тип("АвтоЭлементПорядкаКомпоновкиДанных"));
		
	Структура = Структура.Структура.Добавить(Тип("ГруппировкаКомпоновкиДанных"));
	Структура.Выбор.Элементы.Добавить(Тип("АвтоВыбранноеПолеКомпоновкиДанных"));
	
	БухгалтерскиеОтчетыКлиентСервер.ДобавитьВыбранноеПоле(Структура.Выбор, "ОбъектНалогообложения");
	БухгалтерскиеОтчетыКлиентСервер.ДобавитьВыбранноеПоле(Структура.Выбор, "ПоказательРасчетаИмя");
	БухгалтерскиеОтчетыКлиентСервер.ДобавитьВыбранноеПоле(Структура.Выбор, "ПоказательРасчетаЗначение");
	БухгалтерскиеОтчетыКлиентСервер.ДобавитьВыбранноеПоле(Структура.Выбор, "СтавкаНалога");
	БухгалтерскиеОтчетыКлиентСервер.ДобавитьВыбранноеПоле(Структура.Выбор, "ПревышениеОбъема");
	
	Если ПараметрыОтчета.Свойство("МестныйБюджет") Тогда
		БухгалтерскиеОтчетыКлиентСервер.ДобавитьОтбор(КомпоновщикНастроек, "МестныйБюджет", ПараметрыОтчета.МестныйБюджет);
	КонецЕсли;

КонецПроцедуры

