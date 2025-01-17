﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

////////////////////////////////////////////////////////////////////////////////
// ПРОГРАММНЫЙ ИНТЕРФЕЙС

Процедура СформироватьОтчет(Знач ПараметрыОтчета, АдресХранилища) Экспорт
	
	Результат = Новый ТабличныйДокумент;
	
	СформироватьЛичныеКарточки(Результат, ПараметрыОтчета);
	
	ПоместитьВоВременноеХранилище(Новый Структура("Результат", Результат), АдресХранилища);
	
	
КонецПроцедуры


////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ


////////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ

Процедура СформироватьЛичныеКарточки(ТабличныйДокумент, ПараметрыОтчета)
	
	Физлицо                 = ПараметрыОтчета.Физлицо;
	ДатаАктуальности        = ПараметрыОтчета.ДатаАктуальности;
	СписокСтруктурныхЕдиниц = ПараметрыОтчета.СписокСтруктурныхЕдиниц;
	
	Запрос = Новый Запрос;
	  
	Запрос.УстановитьПараметр("ДатаАктуальности",	     ДатаАктуальности);
	Запрос.УстановитьПараметр("Физлицо",			     Физлицо);
    Запрос.УстановитьПараметр("СписокСтруктурныхЕдиниц", СписокСтруктурныхЕдиниц);

	// найдем организации, по которым формировать отчет
	Если СписокСтруктурныхЕдиниц.Количество() = 1 Тогда
		Запрос.УстановитьПараметр("СписокГоловныхОрганизаций", ОбщегоНазначенияБКВызовСервера.ГоловнаяОрганизацияДляУчетаЗарплаты(СписокСтруктурныхЕдиниц[0].Значение));
	Иначе
		УчетнаяПолитикаПоПерсоналуОрганизацииТаблица = ПолныеПраваПовтИсп.СформироватьТаблицуУчетнойПолитикиПоПерсоналу();		
		Запрос.УстановитьПараметр("парамУчетнаяПолитикаПоПерсоналуОрганизации", УчетнаяПолитикаПоПерсоналуОрганизацииТаблица);		
		
		// составим список всех головных организаций по списку структурных единиц
		Запрос.Текст = "ВЫБРАТЬ
		               |	УчетнаяПолитика.Организация,
		               |	УчетнаяПолитика.ВедениеУчетаПоГоловнойОрганизации
		               |ПОМЕСТИТЬ ВТ_УчетнаяПолитикаПоПерсоналуОрганизации
		               |ИЗ
		               |	&парамУчетнаяПолитикаПоПерсоналуОрганизации КАК УчетнаяПолитика
		               |;
		               |
		               |////////////////////////////////////////////////////////////////////////////////
		               |ВЫБРАТЬ РАЗРЕШЕННЫЕ РАЗЛИЧНЫЕ
		               |	ВЫБОР
		               |		КОГДА ВТ_УчетнаяПолитикаПоПерсоналуОрганизации.ВедениеУчетаПоГоловнойОрганизации
		               |			ТОГДА ВЫБОР
		               |					КОГДА Организации.ГоловнаяОрганизация = ЗНАЧЕНИЕ(Справочник.Организации.ПустаяСсылка)
		               |						ТОГДА Организации.Ссылка
		               |					ИНАЧЕ Организации.ГоловнаяОрганизация
		               |				КОНЕЦ
		               |		ИНАЧЕ Организации.Ссылка
		               |	КОНЕЦ КАК ГоловнаяОрганизация
		               |ИЗ
		               |	Справочник.Организации КАК Организации
		               |		ЛЕВОЕ СОЕДИНЕНИЕ ВТ_УчетнаяПолитикаПоПерсоналуОрганизации КАК ВТ_УчетнаяПолитикаПоПерсоналуОрганизации
		               |		ПО Организации.Ссылка = ВТ_УчетнаяПолитикаПоПерсоналуОрганизации.Организация
		               |ГДЕ
		               |	Организации.Ссылка В(&СписокСтруктурныхЕдиниц)
		               |	И (НЕ Организации.Наименование ЕСТЬ NULL ) // для корректной работы RLS";
		
		Запрос.УстановитьПараметр("СписокГоловныхОрганизаций", Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("ГоловнаяОрганизация"));
	КонецЕсли;

	Запрос.Текст	=	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	            	 	|	РаботникиОрганизацииСрезПоследних.Сотрудник.Код КАК ТабельныйНомер,";
	            	 	Если СписокСтруктурныхЕдиниц.Количество() = 1 Тогда
		            	 	Запрос.Текст = Запрос.Текст + "
	            	 	|	ВЫРАЗИТЬ(РаботникиОрганизацииСрезПоследних.ОбособленноеПодразделение.НаименованиеПолное КАК СТРОКА(1000)) КАК НаименованиеПолноеОрганизации,";
	            	 	Иначе
		            	 	Запрос.Текст = Запрос.Текст + "
	            	 	|	ВЫРАЗИТЬ(РаботникиОрганизацииСрезПоследних.Организация.НаименованиеПолное КАК СТРОКА(1000)) КАК НаименованиеПолноеОрганизации,";
	            	 	КонецЕсли;
						Запрос.Текст = Запрос.Текст + "
	            	 	|	ФизическиеЛица.Наименование КАК Представление,
	            	 	|	ВЫБОР 
	            	 	|		КОГДА ФизическиеЛица.ДатаРождения = ДАТАВРЕМЯ(1,1,1) ТОГДА """" 
	            	 	|		ИНАЧЕ ГОД(ФизическиеЛица.ДатаРождения)
	            	 	|	КОНЕЦ КАК ГодРождения,
	            	 	|	ВЫБОР 
	            	 	|		КОГДА ФизическиеЛица.ДатаРождения = ДАТАВРЕМЯ(1,1,1) ТОГДА """" 
	            	 	|		ИНАЧЕ МЕСЯЦ(ФизическиеЛица.ДатаРождения) 
	            	 	|	КОНЕЦ КАК МесяцРождения,
	            	 	|	ВЫБОР 
	            	 	|		КОГДА ФизическиеЛица.ДатаРождения = ДАТАВРЕМЯ(1,1,1) ТОГДА """" 
	            	 	|		ИНАЧЕ ДЕНЬ(ФизическиеЛица.ДатаРождения) 
	            	 	|	КОНЕЦ КАК ЧислоРождения,
	            	 	|	ФизическиеЛица.МестоРождения,
	            	 	|	ФИОФизЛицСрезПоследних.Фамилия,
	            	 	|	ФИОФизЛицСрезПоследних.Имя,
	            	 	|	ФИОФизЛицСрезПоследних.Отчество,
	            	 	|	ПаспортныеДанныеФизЛицСрезПоследних.ДокументВид.Наименование КАК ВидДокумента,
	            	 	|	ВЫРАЗИТЬ(ПаспортныеДанныеФизЛицСрезПоследних.ДокументКемВыдан КАК СТРОКА(1000)) КАК ДокументКемВыдан,
	            	 	|	ВЫБОР 
	            	 	|		КОГДА (ПаспортныеДанныеФизЛицСрезПоследних.ДокументДатаВыдачи) ЕСТЬ NULL  ТОГДА ДАТАВРЕМЯ(1,1,1) 
	            	 	|		ИНАЧЕ ПаспортныеДанныеФизЛицСрезПоследних.ДокументДатаВыдачи 
	            	 	|	КОНЕЦ КАК ДокументДатаВыдачи,
	            	 	|	ПаспортныеДанныеФизЛицСрезПоследних.ДокументНомер,
	            	 	|	ПаспортныеДанныеФизЛицСрезПоследних.ДокументСерия,
	            	 	|	ВЫРАЗИТЬ(КонтактнаяИнформацияАдрес.Представление КАК СТРОКА(1000)) КАК ДомашнийАдрес,
	            	 	|	ВЫРАЗИТЬ(КонтактнаяИнформацияТелефон.Представление КАК СТРОКА(1000)) КАК Телефон	            	 	
	            	 	|
	            	 	|ИЗ
	            	 	|	Справочник.ФизическиеЛица КАК ФизическиеЛица
	            	 	|	ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ПаспортныеДанныеФизЛиц.СрезПоследних(&ДатаАктуальности, ФизЛицо = &ФизЛицо) КАК ПаспортныеДанныеФизЛицСрезПоследних
	            	 	|		ПО ФизическиеЛица.Ссылка = ПаспортныеДанныеФизЛицСрезПоследних.ФизЛицо
	            	 	|
	            	 	|	ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ФИОФизЛиц.СрезПоследних(&ДатаАктуальности, ФизЛицо = &ФизЛицо) КАК ФИОФизЛицСрезПоследних
	            	 	|		ПО ФизическиеЛица.Ссылка = ФизическиеЛица.Ссылка
	            	 	|
	            	 	|	ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.КонтактнаяИнформация КАК КонтактнаяИнформацияАдрес
	            	 	|		ПО ФизическиеЛица.Ссылка = КонтактнаяИнформацияАдрес.Объект 
	            	 	|		   И (КонтактнаяИнформацияАдрес.Тип = ЗНАЧЕНИЕ(Перечисление.ТипыКонтактнойИнформации.Адрес)) 
	            	 	|		   И (КонтактнаяИнформацияАдрес.Вид = ЗНАЧЕНИЕ(Справочник.ВидыКонтактнойИнформации.ЮрАдресФизЛица))
	            	 	|
	            	 	|	ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.КонтактнаяИнформация КАК КонтактнаяИнформацияТелефон
	            	 	|		ПО ФизическиеЛица.Ссылка = КонтактнаяИнформацияТелефон.Объект 
	            	 	|		   И (КонтактнаяИнформацияТелефон.Тип = ЗНАЧЕНИЕ(Перечисление.ТипыКонтактнойИнформации.Телефон)) 
	            	 	|		   И (КонтактнаяИнформацияТелефон.Вид = ЗНАЧЕНИЕ(Справочник.ВидыКонтактнойИнформации.ТелефонФизЛица))
	            	 	|
	            	 	|	ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.РаботникиОрганизаций.СрезПоследних(
	            	 	|			&ДатаАктуальности, 
	            	 	|			Сотрудник.ФизЛицо = &ФизЛицо 
	            	 	|			И Сотрудник.ВидЗанятости <> ЗНАЧЕНИЕ(Перечисление.ВидыЗанятостиВОрганизации.ВнутреннееСовместительство)) КАК РаботникиОрганизацииСрезПоследних
	            	 	|		ПО ФизическиеЛица.Ссылка = РаботникиОрганизацииСрезПоследних.Сотрудник.Физлицо 
	            	 	|		   И РаботникиОрганизацииСрезПоследних.ОбособленноеПодразделение В (&СписокСтруктурныхЕдиниц)
	            	 	|
	            	 	|ГДЕ
	            	 	|	ФизическиеЛица.Ссылка = &Физлицо
						|УПОРЯДОЧИТЬ ПО
						|	РаботникиОрганизацииСрезПоследних.Период УБЫВ";
                        
	РезультатЗапроса 	= 	Запрос.Выполнить();
	ВыборкаРезультата	=	РезультатЗапроса.Выбрать();

 	Макет 					= 	ПолучитьМакет("Т2");
	ПерваяСтраницаТ2		= 	Макет.ПолучитьОбласть("ПерваяСтраницаТ2");
	ВоинскийУчет			= 	Макет.ПолучитьОбласть("ВоинскийУчет");
	ШапкаНазначения 		= 	Макет.ПолучитьОбласть("ШапкаНазначения");
	СтрокаНазначения		=	Макет.ПолучитьОбласть("СтрокаНазначения");
	ШапкаОтпуска	 		= 	Макет.ПолучитьОбласть("ШапкаОтпуска");
	СтрокаОтпуска			=	Макет.ПолучитьОбласть("СтрокаОтпуска");
	ДополнительныеСведения	=	Макет.ПолучитьОбласть("ДополнительныеСведения");
	
	Если ВыборкаРезультата.Следующий() тогда
		
		Если ВыборкаРезультата.ТабельныйНомер = NULL Тогда
			ТекстСообщения = НСтр("ru = 'Работник не работает в выбранной организации!'");
			ОбщегоНазначения.СообщитьПользователю(ТекстСообщения, , "ФизЛицо", "Отчет");
			Возврат;
		КонецЕсли;
	
		ПерваяСтраницаТ2.Параметры.Заполнить(ВыборкаРезультата);
		
		Если ВыборкаРезультата.Фамилия = NULL тогда
			ФИО = СтроковыеФункцииКлиентСервер.РазложитьСтрокуВМассивПодстрок(ВыборкаРезультата.Представление, " ");
			Если ФИО.Количество() > 0	тогда
				Фамилия	 = ФИО[0];
			КонецЕсли;
			Если ФИО.Количество() > 1	тогда
				Имя		 = ФИО[1];
			КонецЕсли;
			Если ФИО.Количество() > 2	тогда
				Отчество = ФИО[2];
			КонецЕсли;
			// ФИО
			ПерваяСтраницаТ2.Параметры.Фамилия  = Фамилия;
			ПерваяСтраницаТ2.Параметры.Имя      = Имя;
			ПерваяСтраницаТ2.Параметры.Отчество = Отчество;
		КонецЕсли;
		
		ПерваяСтраницаТ2.Параметры.НаименованиеОрганизации	= ВыборкаРезультата.НаименованиеПолноеОрганизации;
		
		ПерваяСтраницаТ2.Параметры.МестоРождения			= ПредставлениеМестаРожденияКраткое(ВыборкаРезультата.МестоРождения);
		ПерваяСтраницаТ2.Параметры.ДатаАктуальности			= ДатаАктуальности;
		
		// ПАСПОРТ
		Если ВыборкаРезультата.ВидДокумента <> Null Тогда
			ПерваяСтраницаТ2.Параметры.ДокументНомер = ?(ВыборкаРезультата.ДокументСерия <> "", НСтр("ru = ' сер. '") + СокрЛП(ВыборкаРезультата.ДокументСерия), "") 
				+ ?(ВыборкаРезультата.ДокументНомер <> "", " " + СокрЛП(ВыборкаРезультата.ДокументНомер), "");
			ПерваяСтраницаТ2.Параметры.ВидДокумента = НСтр("ru = 'Документ, удостоверяющий личность: '") + ВыборкаРезультата.ВидДокумента;
			ПерваяСтраницаТ2.Параметры.ДокументКемВыдан   = СокрЛП(ВыборкаРезультата.ДокументКемВыдан);
			ПерваяСтраницаТ2.Параметры.ДокументДатаВыдачи = Формат(ВыборкаРезультата.ДокументДатаВыдачи,"ДЛФ=D");
		КонецЕсли;
		
		// АДРЕС
		Если ЗначениеЗаполнено(ВыборкаРезультата.ДомашнийАдрес) Тогда
			ПерваяСтраницаТ2.Параметры.ДомашнийАдрес1 = Сред(ВыборкаРезультата.ДомашнийАдрес, 1, 30);
			ПерваяСтраницаТ2.Параметры.ДомашнийАдрес2 = Сред(ВыборкаРезультата.ДомашнийАдрес, 31);
		КонецЕсли;
		ПерваяСтраницаТ2.Параметры.Телефон = ВыборкаРезультата.Телефон;
	
	КонецЕсли;
	
	// выводим первую страницу
	ТабличныйДокумент.Вывести(ПерваяСтраницаТ2);
	ТабличныйДокумент.Вывести(ВоинскийУчет);

	// ПРИЕМ И ПЕРЕВОДЫ НА ДРУГУЮ РАБОТУ
	Запрос.Текст =	
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	МИНИМУМ(ДатыПриемовВОрганизации.Период) КАК Период
	|ИЗ
	|	(ВЫБРАТЬ
	|			РаботникиОрганизацийСрезПоследних.Организация,
	|			МАКСИМУМ(РаботникиОрганизацийСрезПоследних.Период) КАК Период
	|		ИЗ
	|			РегистрСведений.РаботникиОрганизаций.СрезПоследних(
	|						&ДатаАктуальности,
	|						Сотрудник.Физлицо = &Физлицо
	|						И Организация В (&СписокГоловныхОрганизаций)
	|						И Сотрудник.ВидЗанятости <> ЗНАЧЕНИЕ(Перечисление.ВидыЗанятостиВОрганизации.ВнутреннееСовместительство)
	|						И ПричинаИзмененияСостояния = ЗНАЧЕНИЕ(Перечисление.ПричиныИзмененияСостояния.ПриемНаРаботу)) КАК РаботникиОрганизацийСрезПоследних
	|		СГРУППИРОВАТЬ ПО
	|			РаботникиОрганизацийСрезПоследних.Организация) КАК ДатыПриемовВОрганизации";
	
	ВыборкаРезультата = Запрос.Выполнить().Выбрать();
	ДатаПриема = Дата(1,1,1);
	Если ВыборкаРезультата.Следующий() Тогда
		ДатаПриема = ВыборкаРезультата.Период;	
	КонецЕсли;
	Запрос.УстановитьПараметр("ДатаПриема", ДатаПриема);
	
	Запрос.Текст	=	
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	Работники.Сотрудник.ВидЗанятости КАК ВидЗанятости,
	|	Работники.Должность.Наименование КАК Должность,
	|	Работники.ПодразделениеОрганизации.Наименование КАК ПодразделениеОрганизации,
	|	Работники.Сотрудник.Код КАК ТабельныйНомер,
	|	Работники.Период КАК ДатаПеревода,
	|	Работники.Сотрудник КАК Сотрудник,
	|	Работники.Регистратор КАК Регистратор,
	|	Работники.Регистратор.Дата КАК ДатаПриказа,
	|	Работники.Регистратор.Номер КАК НомерПриказа,
	|	УвольненияРаботники.СтатьяЗаконаОТрудеРК.Наименование КАК ОснованиеУвольнения,
	|	УвольненияРаботники.ДатаУвольнения КАК ДатаУвольнения,
	|	УвольненияРаботники.Ссылка.Номер КАК НомерПриказаУвольнения,
	|	УвольненияРаботники.Ссылка.Дата КАК ДатаПриказаУвольнения,
	|	ЕСТЬNULL(ПлановыеНачисленияРаботниковОрганизаций.Размер, 0) КАК ТарифнаяСтавка
	|ИЗ
	|	РегистрСведений.РаботникиОрганизаций КАК Работники
	|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.УвольнениеИзОрганизаций.РаботникиОрганизации КАК УвольненияРаботники
	|		ПО Работники.Сотрудник = УвольненияРаботники.Сотрудник
	|			И Работники.Регистратор = УвольненияРаботники.Ссылка
	|		ЛЕВОЕ СОЕДИНЕНИЕ (ВЫБРАТЬ
	|			РаботникиОрганизации.Сотрудник КАК Сотрудник,
	|			РаботникиОрганизации.Организация КАК Организация,
	|			РаботникиОрганизации.Период КАК Период,
	|			МАКСИМУМ(ПлановыеНачисления.Период) КАК ПериодНачислений
	|		ИЗ
	|			РегистрСведений.РаботникиОрганизаций КАК РаботникиОрганизации
	|				ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ПлановыеНачисленияРаботниковОрганизаций КАК ПлановыеНачисления
	|				ПО (РаботникиОрганизации.Сотрудник.Физлицо = &ФизЛицо)
	|					И РаботникиОрганизации.Сотрудник = ПлановыеНачисления.Сотрудник
	|					И РаботникиОрганизации.Организация = ПлановыеНачисления.Организация
	|					И (ПлановыеНачисления.Период <= РаботникиОрганизации.Период)
	|					И (ПлановыеНачисления.ВидРасчетаИзмерение.Код ЕСТЬ NULL)
	|					И (ПлановыеНачисления.Размер <> 0)
	|		ГДЕ
	|			РаботникиОрганизации.Организация В(&СписокГоловныхОрганизаций)
	|			И РаботникиОрганизации.Сотрудник.Физлицо = &ФизЛицо
	|			И РаботникиОрганизации.Период МЕЖДУ &ДатаПриема И &ДатаАктуальности
	|		
	|		СГРУППИРОВАТЬ ПО
	|			РаботникиОрганизации.Сотрудник,
	|			РаботникиОрганизации.Организация,
	|			РаботникиОрганизации.Период) КАК ПлановыеНачисленияСрезПоследних
	|		ПО Работники.Сотрудник = ПлановыеНачисленияСрезПоследних.Сотрудник
	|			И Работники.Период = ПлановыеНачисленияСрезПоследних.Период
	|			И Работники.Организация = ПлановыеНачисленияСрезПоследних.Организация
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ПлановыеНачисленияРаботниковОрганизаций КАК ПлановыеНачисленияРаботниковОрганизаций
	|		ПО (ПлановыеНачисленияСрезПоследних.Сотрудник = ПлановыеНачисленияРаботниковОрганизаций.Сотрудник)
	|			И (ПлановыеНачисленияСрезПоследних.ПериодНачислений = ПлановыеНачисленияРаботниковОрганизаций.Период)
	|			И (ПлановыеНачисленияСрезПоследних.Организация = ПлановыеНачисленияРаботниковОрганизаций.Организация)
	|			И (ПлановыеНачисленияРаботниковОрганизаций.ВидРасчетаИзмерение.Код ЕСТЬ NULL)
	|			И (ПлановыеНачисленияРаботниковОрганизаций.Размер <> 0)
	|ГДЕ
	|	ВЫБОР
	|			КОГДА Работники.ПричинаИзмененияСостояния = ЗНАЧЕНИЕ(Перечисление.ПричиныИзмененияСостояния.Увольнение)
	|				ТОГДА ДОБАВИТЬКДАТЕ(Работники.Период, ДЕНЬ, -1)
	|			ИНАЧЕ Работники.Период
	|		КОНЕЦ МЕЖДУ &ДатаПриема И &ДатаАктуальности
	|	И Работники.Сотрудник.Физлицо = &Физлицо
	|	И Работники.Организация В(&СписокГоловныхОрганизаций)
	|	И Работники.ОбособленноеПодразделение В(&СписокСтруктурныхЕдиниц)
	|
	|УПОРЯДОЧИТЬ ПО
	|	ДатаПеревода";
	
	РезультатЗапроса 	= 	Запрос.Выполнить();
	ВыборкаРезультата	=	РезультатЗапроса.Выбрать();
	инд	=	0;
	ДополнительныеСведения.Параметры.ДатаИПричинаУвольнения = "";
	РеглВалюта = ОбщегоНазначенияБКВызовСервераПовтИсп.ПолучитьВалютуРегламентированногоУчета();
	
	// шапка таблицы назначений
	ТабличныйДокумент.Вывести(ШапкаНазначения);
	
	Пока ВыборкаРезультата.Следующий()	Цикл
		
		Если ЗначениеЗаполнено(ВыборкаРезультата.ДатаУвольнения) тогда
			
				//Встретили увольнение документом "Прием на работу" или "Увольнение"
				ДополнительныеСведения.Параметры.Регистратор = ВыборкаРезультата.Регистратор;
				ДополнительныеСведения.Параметры.ДатаИПричинаУвольнения	= Формат(ВыборкаРезультата.ДатаУвольнения, "ДЛФ=D") + ", "
					+ СокрЛП(ВыборкаРезультата.ОснованиеУвольнения) + НСтр("ru = ', приказ (распоряжение) №'") + СокрЛП(ВыборкаРезультата.НомерПриказаУвольнения) 
					+ НСтр("ru = ' от '") + Формат(ВыборкаРезультата.ДатаПриказаУвольнения, "ДФ=дд.ММ.гггг");

		Иначе// Кадровое назначение	
			
			инд	= инд + 1;
			
			СтрокаНазначения.Параметры.Регистратор 				= 	ВыборкаРезультата.Регистратор;
			СтрокаНазначения.Параметры.ДатаНазначения			=	ВыборкаРезультата.ДатаПеревода;
			СтрокаНазначения.Параметры.ПодразделениеНазначения	=	ВыборкаРезультата.ПодразделениеОрганизации;
			СтрокаНазначения.Параметры.ДолжностьНазначения		=	ВыборкаРезультата.Должность;
			Если ВыборкаРезультата.ВидЗанятости = Перечисления.ВидыЗанятостиВОрганизации.Совместительство Тогда
				СтрокаНазначения.Параметры.ДолжностьНазначения	=	СтрокаНазначения.Параметры.ДолжностьНазначения + НСтр("ru = ' (внеш.совмест-ль)'");
			ИначеЕсли ВыборкаРезультата.ВидЗанятости = Перечисления.ВидыЗанятостиВОрганизации.ВнутреннееСовместительство Тогда
				СтрокаНазначения.Параметры.ДолжностьНазначения	=	СтрокаНазначения.Параметры.ДолжностьНазначения + НСтр("ru = ' (внутр.совмест-ль)'");
			КонецЕсли;
		
			ТарифнаяСтавка	= ВыборкаРезультата.ТарифнаяСтавка;
			СтрокаНазначения.Параметры.ОкладНазначения     = ТарифнаяСтавка;
			СтрокаНазначения.Параметры.ОснованиеНазначения = НСтр("ru = 'Пр.№ '") + СокрЛП(ВыборкаРезультата.НомерПриказа) + НСтр("ru = ' от '") + Формат(ВыборкаРезультата.ДатаПриказа, "ДФ=dd.MM.yy");
			
			ТабличныйДокумент.Вывести(СтрокаНазначения);			
		КонецЕсли;
	КонецЦикла;

	// Добьем до 10 строк
	// уберем все параметры, чтобы были пустые строки
	Для Инд2 = 0 По СтрокаНазначения.Параметры.Количество() - 1 Цикл
		СтрокаНазначения.Параметры[Инд2] = Неопределено;
	КонецЦикла;	

	Для Инд2 = Инд + 1 По 10 Цикл
		ТабличныйДокумент.Вывести(СтрокаНазначения);
	КонецЦикла;
	
	// ОТПУСКА
	ТабличныйДокумент.Вывести(ШапкаОтпуска);
	
	Запрос.УстановитьПараметр("ПоСреднемуЗаработкуДляОтпуска", Перечисления.СпособыРасчетаОплатыТруда.ПоСреднемуЗаработкуДляОтпуска);
	Запрос.УстановитьПараметр("ДатаНачалаРасчетаСреднегоЗаработкаТолькоПоРабочимДням", ПроведениеРасчетовСервер.ПолучитьДатуНачалаРасчетаСреднегоЗаработкаТолькоПоРабочимДням());
	
	Запрос.Текст = "
	|ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	Начисления.Ссылка КАК Регистратор,
	|	Начисления.Ссылка.Дата КАК ДатаПриказа,
	|	Начисления.Ссылка.Номер КАК НомерПриказа,
	|	Начисления.ВидРасчета.Наименование КАК ВидОтпуска,
	|	Начисления.ДатаНачала КАК НачалоОтпуска,
	|	Начисления.ДатаОкончания КАК ОкончаниеОтпуска,
	|	ВЫБОР
	|		КОГДА ДатыУходаВОтпуск.ДатаНачалаСобытия < &ДатаНачалаРасчетаСреднегоЗаработкаТолькоПоРабочимДням
	|			ТОГДА Начисления.ОтработаноДней
	|		ИНАЧЕ Начисления.ДополнительныеДанные
	|	КОНЕЦ КАК Продолжительность,
	|	ВЫРАЗИТЬ(Начисления.Ссылка.Комментарий КАК СТРОКА(250)) КАК ОснованиеОтпуска
	|ИЗ
	|	Документ.НачислениеЗарплатыРаботникамОрганизаций.Начисления КАК Начисления
	|
	|	ЛЕВОЕ СОЕДИНЕНИЕ (ВЫБРАТЬ
	|							Начисления.Ссылка,
	|							МИНИМУМ(Начисления.ДатаНачала) КАК ДатаНачалаСобытия
	|						ИЗ
	|							Документ.НачислениеЗарплатыРаботникамОрганизаций.Начисления КАК Начисления
	|						ГДЕ
	|							Начисления.Ссылка.Проведен
	|							И Начисления.Ссылка.Организация В (&СписокСтруктурныхЕдиниц)
	|							И Начисления.ФизЛицо = &ФизЛицо
	|							И Начисления.ДатаНачала >= &ДатаПриема
	|							И Начисления.ВидРасчета.СпособРасчета = &ПоСреднемуЗаработкуДляОтпуска
	|						СГРУППИРОВАТЬ ПО
	|							Начисления.Ссылка) КАК ДатыУходаВОтпуск
	|		ПО Начисления.Ссылка = ДатыУходаВОтпуск.Ссылка
	|
	|ГДЕ
	|	Начисления.Ссылка.Проведен 
	|	И Начисления.Ссылка.Организация В (&СписокСтруктурныхЕдиниц)
	|	И Начисления.ФизЛицо = &ФизЛицо
	|	И Начисления.ДатаНачала >= &ДатаПриема
	|	И Начисления.ВидРасчета.СпособРасчета = &ПоСреднемуЗаработкуДляОтпуска
	|УПОРЯДОЧИТЬ ПО
	|	ДатаПриказа,
	|	НачалоОтпуска
	|";
	
	РезультатЗапроса 	= 	Запрос.Выполнить();
	ВыборкаРезультата	=	РезультатЗапроса.Выбрать();
	инд	=	0;
	Пока ВыборкаРезультата.Следующий()	Цикл
		
		инд	= инд + 1;
			
		СтрокаОтпуска.Параметры.Заполнить(ВыборкаРезультата);
		
		СтрокаОтпуска.Параметры.ОснованиеОтпуска = СтрокаОтпуска.Параметры.ОснованиеОтпуска + 
													НСтр("ru = 'пр.№ '") + СокрЛП(ВыборкаРезультата.НомерПриказа) +
													НСтр("ru = ' от '")  + Формат(ВыборкаРезультата.ДатаПриказа, "ДФ=dd.MM.yy");

		ТабличныйДокумент.Вывести(СтрокаОтпуска);
		
	КонецЦикла;
	
	// Добьем пустыми строками до 10
	Для Инд2 = 0 По СтрокаОтпуска.Параметры.Количество() - 1 Цикл
		СтрокаОтпуска.Параметры[инд2] = Неопределено;
	КонецЦикла;
	
	Для Инд2 = Инд + 1 По 10 Цикл
		ТабличныйДокумент.Вывести(СтрокаОтпуска);
	КонецЦикла;
	
	// Дополнительные сведения
	ТабличныйДокумент.Вывести(ДополнительныеСведения);

	//Параметры документа
	ТабличныйДокумент.ИмяПараметровПечати 	= "ПАРАМЕТРЫ_ПЕЧАТИ_Форма_Т2";
	ТабличныйДокумент.ОриентацияСтраницы 	= ОриентацияСтраницы.Портрет;
	ТабличныйДокумент.ПолеСлева             = 0;
	ТабличныйДокумент.ПолеСправа            = 0;
	
КонецПроцедуры


/////////////////////////////////////////////
// Процедуры общих модулей

// Возвращает строковое представление места рождения без описания административных единиц
//
Функция ПредставлениеМестаРожденияКраткое(Знач СтрокаМестоРождения) Экспорт

	СтруктураМестоРождения = РазложитьМестоРождения(СтрокаМестоРождения, Ложь);
	
	Представление	= "" + ?(НЕ ЗначениеЗаполнено(СтруктураМестоРождения.НаселенныйПункт), "", СокрЛП(СтруктураМестоРождения.НаселенныйПункт))
	+?(НЕ ЗначениеЗаполнено(СтруктураМестоРождения.Район),	"",	", " + СокрЛП(СтруктураМестоРождения.Район))
	+?(НЕ ЗначениеЗаполнено(СтруктураМестоРождения.Область),	"",	", "	+	СокрЛП(СтруктураМестоРождения.Область))
	+?(НЕ ЗначениеЗаполнено(СтруктураМестоРождения.Страна),	"",	", "	+	СокрЛП(СтруктураМестоРождения.Страна));
	
	Если Лев(Представление, 1) = ","  Тогда
		Представление = Сред(Представление, 2)
	КонецЕсли;
	
	Возврат Представление;
	
КонецФункции // ПредставлениеМестаРожденияКраткое()

//Функция раскладывает строку с данными о месте рождения на элементы структуры
//
Функция РазложитьМестоРождения(Знач СтрокаМестоРождения, ВерхнийРегистр = Истина) Экспорт

	НаселенныйПункт		= "";
	Район				= "";
	Область				= "";
	Страна				= "";
	МассивМестоРождения	= СтроковыеФункцииКлиентСервер.РазложитьСтрокуВМассивПодстрок(?(ВерхнийРегистр, Врег(СтрокаМестоРождения), СтрокаМестоРождения));
	ЭлементовВМассиве	= МассивМестоРождения.Количество();   
	
	Если ЭлементовВМассиве	>	0	тогда
		НаселенныйПункт	=	СокрЛП(МассивМестоРождения[0]);
	КонецЕсли;
	
	Если ЭлементовВМассиве	>	1	тогда
		Район	=	СокрЛП(МассивМестоРождения[1]);
	КонецЕсли;
	
	Если ЭлементовВМассиве	>	2	тогда
		Область	=	СокрЛП(МассивМестоРождения[2]);
	КонецЕсли;
	
	Если ЭлементовВМассиве	>	3	тогда
		Страна	=	СокрЛП(МассивМестоРождения[3]);
	КонецЕсли;

	СтруктураВозврата = Новый Структура;
	СтруктураВозврата.Вставить("НаселенныйПункт",НаселенныйПункт);
	СтруктураВозврата.Вставить("Район",Район);
	СтруктураВозврата.Вставить("Область",Область);
	СтруктураВозврата.Вставить("Страна",Страна);
	
	Возврат СтруктураВозврата;
	
КонецФункции // РазложитьМестоРождения()

#КонецЕсли