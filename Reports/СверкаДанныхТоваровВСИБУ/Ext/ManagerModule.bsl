﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	
	////////////////////////////////////////////////////////////////////////////////
	// ПРОГРАММНЫЙ ИНТЕРФЕЙС
	
	Функция ПолучитьПараметрыИсполненияОтчета() Экспорт
		
		Возврат Новый Структура("ИспользоватьПередКомпоновкойМакета,
		|ИспользоватьПослеКомпоновкиМакета,
		|ИспользоватьПослеВыводаРезультата,
		|ИспользоватьДанныеРасшифровки",
		Истина, Истина, Истина, Истина);
		
	КонецФункции
	
	Функция ПолучитьТекстЗаголовка(ПараметрыОтчета, ОрганизацияВНачале = Истина) Экспорт
		
		ЗаголовокОтчета = НСтр("ru = 'Сверка ТМЗ по данным бухгалтерского учета и регистра ""Товары на виртуальных складах"" %1
		|по счетам: %2'");
		ЗаголовокОтчета = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ЗаголовокОтчета,
		БухгалтерскиеОтчетыКлиентСервер.ПолучитьПредставлениеПериода(ПараметрыОтчета.НачалоПериода, ПараметрыОтчета.КонецПериода), ПараметрыОтчета.СписокСчетов);
		
		Возврат ЗаголовокОтчета;
		
	КонецФункции
	
	// В процедуре можно доработать компоновщик перед выводом в отчет
	// Изменения сохранены не будут
	Процедура ПередКомпоновкойМакета(ПараметрыОтчета, Схема, КомпоновщикНастроек) Экспорт
		
		КомпоновщикНастроек.Настройки.Структура.Очистить();
		КомпоновщикНастроек.Настройки.Выбор.Элементы.Очистить();
		
		Если ЗначениеЗаполнено(ПараметрыОтчета.НачалоПериода) Тогда
			БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "НачалоПериода", НачалоДня(ПараметрыОтчета.НачалоПериода));
		Иначе
			БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "НачалоПериода", Дата(1, 1, 1));
		КонецЕсли;
		Если ЗначениеЗаполнено(ПараметрыОтчета.КонецПериода) Тогда
			БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "КонецПериода", КонецДня(ПараметрыОтчета.КонецПериода));
		Иначе
			БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "КонецПериода", Дата(3999, 11, 1));
		КонецЕсли;
		
		ВидСубконтоНоменклатура = ПланыВидовХарактеристик.ВидыСубконтоТиповые.Номенклатура;
		ВидСубконтоСклады       = ПланыВидовХарактеристик.ВидыСубконтоТиповые.Склады;
		
		ВидыСубконтоНоменклатураСклад = Новый СписокЗначений;
		ВидыСубконтоНоменклатура      = Новый СписокЗначений;
		
		ВидыСубконтоНоменклатураСклад.Добавить(ВидСубконтоНоменклатура);
		ВидыСубконтоНоменклатура.Добавить(ВидСубконтоНоменклатура);
		
		СписокСчетов = ПараметрыОтчета.СписокСчетов.Скопировать();
		СписокСчетовБезСклада = Новый СписокЗначений;
		
		ВидыСубконтоНоменклатураСклад.Добавить(ВидСубконтоСклады);
		Для Каждого Счет Из СписокСчетов Цикл
			Если Не ЗначениеЗаполнено(Счет.Значение) Тогда
				Продолжить;
			КонецЕсли;
			СчетОбъект = Счет.Значение.ПолучитьОбъект();
			Если СчетОбъект <> Неопределено Тогда
				Если СчетОбъект.ВидыСубконто.Найти(ВидСубконтоСклады, "ВидСубконто")= Неопределено Тогда
					СписокСчетовБезСклада.Добавить(Счет.Значение);
				КонецЕсли;
			КонецЕсли;
		КонецЦикла;
		
		Для Каждого СчетБезСклада Из СписокСчетовБезСклада Цикл
			СписокСчетов.Удалить(СписокСчетов.НайтиПоЗначению(СчетБезСклада.Значение));
		КонецЦикла;
		
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "СписокСчетов"         , СписокСчетов);
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "СписокСчетовБезСклада", СписокСчетовБезСклада);
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ВидыСубконтоНоменклатураСклад", ВидыСубконтоНоменклатураСклад);
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ВидыСубконтоНоменклатура"     , ВидыСубконтоНоменклатура);
		
		БухгалтерскиеОтчеты.ДобавитьОтборПоОрганизациямИПодразделениям(КомпоновщикНастроек, ПараметрыОтчета);
		
		ПоРегистратору = Ложь;
		Структура = КомпоновщикНастроек.Настройки;
		Для Каждого ПолеВыбраннойГруппировки Из ПараметрыОтчета.Группировка Цикл 
			Если ПолеВыбраннойГруппировки.Использование Тогда
				Структура = Структура.Структура.Добавить(Тип("ГруппировкаКомпоновкиДанных"));
				ПолеГруппировки = Структура.ПоляГруппировки.Элементы.Добавить(Тип("ПолеГруппировкиКомпоновкиДанных"));
				ПолеГруппировки.Использование  = Истина;
				ПолеГруппировки.Поле           = Новый ПолеКомпоновкиДанных(ПолеВыбраннойГруппировки.Поле);
				Если ПолеВыбраннойГруппировки.ТипГруппировки = Перечисления.ТипДетализацииСтандартныхОтчетов.Иерархия Тогда
					ПолеГруппировки.ТипГруппировки = ТипГруппировкиКомпоновкиДанных.Иерархия;
				ИначеЕсли ПолеВыбраннойГруппировки.ТипГруппировки = Перечисления.ТипДетализацииСтандартныхОтчетов.ТолькоИерархия Тогда
					ПолеГруппировки.ТипГруппировки = ТипГруппировкиКомпоновкиДанных.ТолькоИерархия;
				Иначе
					ПолеГруппировки.ТипГруппировки = ТипГруппировкиКомпоновкиДанных.Элементы;
				КонецЕсли;
				Структура.Выбор.Элементы.Добавить(Тип("АвтоВыбранноеПолеКомпоновкиДанных"));
				Структура.Порядок.Элементы.Добавить(Тип("АвтоЭлементПорядкаКомпоновкиДанных"));
				
				Если ПолеВыбраннойГруппировки.Поле = "Регистратор" Тогда
					ПоРегистратору = Истина;
				КонецЕсли;
			КонецЕсли;
		КонецЦикла;
		
		// Детализирующая группировка
		Если ПараметрыОтчета.ПоСчетам ИЛИ ПараметрыОтчета.ПоИсточникамПроисхождения Тогда
			
			Структура = Структура.Структура.Добавить(Тип("ГруппировкаКомпоновкиДанных"));
			
			Если ПараметрыОтчета.ПоИсточникамПроисхождения Тогда
				ПолеГруппировки = Структура.ПоляГруппировки.Элементы.Добавить(Тип("ПолеГруппировкиКомпоновкиДанных"));
				ПолеГруппировки.Использование  = Истина;
				ПолеГруппировки.Поле           = Новый ПолеКомпоновкиДанных("ИсточникПроисхождения");
				ПолеГруппировки.ТипГруппировки = ТипГруппировкиКомпоновкиДанных.Элементы;
			КонецЕсли;
			
			Если ПараметрыОтчета.ПоСчетам Тогда
				ПолеГруппировки = Структура.ПоляГруппировки.Элементы.Добавить(Тип("ПолеГруппировкиКомпоновкиДанных"));
				ПолеГруппировки.Использование  = Истина;
				ПолеГруппировки.Поле           = Новый ПолеКомпоновкиДанных("Счет");
				ПолеГруппировки.ТипГруппировки = ТипГруппировкиКомпоновкиДанных.Элементы;
			КонецЕсли;
			
			
			Структура.Выбор.Элементы.Добавить(Тип("АвтоВыбранноеПолеКомпоновкиДанных"));
			Структура.Порядок.Элементы.Добавить(Тип("АвтоЭлементПорядкаКомпоновкиДанных"));
			
		КонецЕсли;
		
		ГруппаТоварыВС = КомпоновщикНастроек.Настройки.Выбор.Элементы.Добавить(Тип("ГруппаВыбранныхПолейКомпоновкиДанных"));
		ГруппаТоварыВС.Заголовок     = НСтр("ru = 'Товары на виртуальных складах'");
		ГруппаТоварыВС.Использование = Истина;
		ГруппаТоварыВС.Расположение  = РасположениеПоляКомпоновкиДанных.Горизонтально;
		Если ПараметрыОтчета.ПоИсточникамПроисхождения Тогда
			БухгалтерскиеОтчетыКлиентСервер.ДобавитьВыбранноеПоле(ГруппаТоварыВС, "ИсточникПроисхождения");
		КонецЕсли;
		
		
		ГруппаБухгалтерскийУчет = КомпоновщикНастроек.Настройки.Выбор.Элементы.Добавить(Тип("ГруппаВыбранныхПолейКомпоновкиДанных"));
		ГруппаБухгалтерскийУчет.Заголовок     = НСтр("ru = 'Бухгалтерский учет'");
		ГруппаБухгалтерскийУчет.Использование = Истина;
		ГруппаБухгалтерскийУчет.Расположение  = РасположениеПоляКомпоновкиДанных.Горизонтально;
		Если ПараметрыОтчета.ПоСчетам Тогда
			БухгалтерскиеОтчетыКлиентСервер.ДобавитьВыбранноеПоле(ГруппаБухгалтерскийУчет, "Счет");
		КонецЕсли;
		
		
		ГруппаОтклонения = КомпоновщикНастроек.Настройки.Выбор.Элементы.Добавить(Тип("ГруппаВыбранныхПолейКомпоновкиДанных"));
		ГруппаОтклонения.Заголовок     = НСтр("ru = 'Отклонения'");
		ГруппаОтклонения.Использование = Истина;
		ГруппаОтклонения.Расположение  = РасположениеПоляКомпоновкиДанных.Горизонтально;
		
		//КомпоновщикНастроек.Настройки.Порядок.Элементы.Добавить(Тип("АвтоЭлементПорядкаКомпоновкиДанных"));
		
		Для Каждого Показатель Из ПараметрыОтчета.Показатели Цикл
			Если Показатель.Использование Тогда
				Если Показатель.Поле = "КоличествоНачальныйОстаток" Тогда
					БухгалтерскиеОтчетыКлиентСервер.ДобавитьВыбранноеПоле(ГруппаТоварыВС, "КоличествоНачальныйОстаток");
				ИначеЕсли Показатель.Поле = "КоличествоПриход" Тогда
					БухгалтерскиеОтчетыКлиентСервер.ДобавитьВыбранноеПоле(ГруппаТоварыВС, "КоличествоПриход");
				ИначеЕсли Показатель.Поле = "КоличествоРасход" Тогда
					БухгалтерскиеОтчетыКлиентСервер.ДобавитьВыбранноеПоле(ГруппаТоварыВС, "КоличествоРасход");
				ИначеЕсли Показатель.Поле = "КоличествоКонечныйОстаток" Тогда
					БухгалтерскиеОтчетыКлиентСервер.ДобавитьВыбранноеПоле(ГруппаТоварыВС, "КоличествоКонечныйОстаток");
				ИначеЕсли Показатель.Поле = "КоличествоНачальныйОстатокБУ" Тогда
					БухгалтерскиеОтчетыКлиентСервер.ДобавитьВыбранноеПоле(ГруппаБухгалтерскийУчет, "КоличествоНачальныйОстатокБУ");
				ИначеЕсли Показатель.Поле = "КоличествоПриходБУ" Тогда
					БухгалтерскиеОтчетыКлиентСервер.ДобавитьВыбранноеПоле(ГруппаБухгалтерскийУчет, "КоличествоПриходБУ");
				ИначеЕсли Показатель.Поле = "КоличествоРасходБУ" Тогда
					БухгалтерскиеОтчетыКлиентСервер.ДобавитьВыбранноеПоле(ГруппаБухгалтерскийУчет, "КоличествоРасходБУ");
				ИначеЕсли Показатель.Поле = "КоличествоКонечныйОстатокБУ" Тогда
					БухгалтерскиеОтчетыКлиентСервер.ДобавитьВыбранноеПоле(ГруппаБухгалтерскийУчет, "КоличествоКонечныйОстатокБУ");
				ИначеЕсли Показатель.Поле = "ОтклонениеНачальныйОстаток" Тогда
					БухгалтерскиеОтчетыКлиентСервер.ДобавитьВыбранноеПоле(ГруппаОтклонения       , "ОтклонениеНачальныйОстаток");
				ИначеЕсли Показатель.Поле = "ОтклонениеПриход" Тогда
					БухгалтерскиеОтчетыКлиентСервер.ДобавитьВыбранноеПоле(ГруппаОтклонения       , "ОтклонениеПриход");
				ИначеЕсли Показатель.Поле = "ОтклонениеРасход" Тогда
					БухгалтерскиеОтчетыКлиентСервер.ДобавитьВыбранноеПоле(ГруппаОтклонения       , "ОтклонениеРасход");
				ИначеЕсли Показатель.Поле = "ОтклонениеКонечныйОстаток" Тогда
					БухгалтерскиеОтчетыКлиентСервер.ДобавитьВыбранноеПоле(ГруппаОтклонения       , "ОтклонениеКонечныйОстаток");
				ИначеЕсли Показатель.Поле = "СвободныйНачальныйОстаток" Тогда
					БухгалтерскиеОтчетыКлиентСервер.ДобавитьВыбранноеПоле(ГруппаТоварыВС       , "СвободныйНачальныйОстаток");
				ИначеЕсли Показатель.Поле = "КоличествоПриходСУчетомРезерва" Тогда
					БухгалтерскиеОтчетыКлиентСервер.ДобавитьВыбранноеПоле(ГруппаТоварыВС       , "КоличествоПриходСУчетомРезерва");
				ИначеЕсли Показатель.Поле = "КоличествоРасходСУчетомРезерва" Тогда
					БухгалтерскиеОтчетыКлиентСервер.ДобавитьВыбранноеПоле(ГруппаТоварыВС       , "КоличествоРасходСУчетомРезерва");
				ИначеЕсли Показатель.Поле = "СвободныйКонечныйОстаток" Тогда
					БухгалтерскиеОтчетыКлиентСервер.ДобавитьВыбранноеПоле(ГруппаТоварыВС       , "СвободныйКонечныйОстаток");
				КонецЕсли;
			КонецЕсли;
		КонецЦикла;
		
		// Дополнительные данные
		//БухгалтерскиеОтчетыВызовСервера.ДобавитьДополнительныеПоля(ПараметрыОтчета, КомпоновщикНастроек);
		
	КонецПроцедуры
	
	Процедура ПослеКомпоновкиМакета(ПараметрыОтчета, МакетКомпоновки) Экспорт
		
		МакетШапкиОтчета = БухгалтерскиеОтчетыВызовСервера.ПолучитьМакетШапки(МакетКомпоновки);
		
		ЗаголовокКолонкиТовар = ""; 
		Для Каждого Строка Из  МакетШапкиОтчета.Макет Цикл
			
			Если Строка.Ячейки[0].Элементы.Количество() > 0 Тогда
				ЗаголовокКолонкиТовар = ЗаголовокКолонкиТовар + ?(ПустаяСтрока(ЗаголовокКолонкиТовар), "", " \ ");
			КонецЕсли;
			
			Для Каждого Элемент Из Строка.Ячейки[0].Элементы Цикл
				ЗаголовокКолонкиТовар = ЗаголовокКолонкиТовар + Элемент.Значение;
			КонецЦикла;
			
		КонецЦикла;
		
		Если МакетШапкиОтчета.Макет.Количество() > 1 Тогда
			
			Ячейка2 = МакетШапкиОтчета.Макет[1].Ячейки[1];
			БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(Ячейка2.Оформление.Элементы, "ОбъединятьПоВертикали", Истина);
			
			МассивДляУдаления = Новый Массив;
			Для Индекс = 2 По МакетШапкиОтчета.Макет.Количество() - 1 Цикл
				МассивДляУдаления.Добавить(МакетШапкиОтчета.Макет[Индекс]);
			КонецЦикла;
			
			Для Каждого Элемент Из МассивДляУдаления Цикл
				МакетШапкиОтчета.Макет.Удалить(Элемент);
			КонецЦикла;
			
			Ячейка2 = МакетШапкиОтчета.Макет[0].Ячейки[0];
			Ячейка2.Элементы.Очистить();
			НовыйЭлемент = Ячейка2.Элементы.Добавить(Тип("ПолеОбластиКомпоновкиДанных"));
			НовыйЭлемент.Значение = ЗаголовокКолонкиТовар;	
			Ячейка2 = МакетШапкиОтчета.Макет[1].Ячейки[0];
			Ячейка2.Элементы.Очистить();
			БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(Ячейка2.Оформление.Элементы, "ОбъединятьПоВертикали", Истина);
			
		КонецЕсли;
		
	КонецПроцедуры
	
	Процедура ПослеВыводаРезультата(ПараметрыОтчета, Результат) Экспорт
		
		БухгалтерскиеОтчетыВызовСервера.ОбработкаРезультатаОтчета(ПараметрыОтчета.ИдентификаторОтчета, Результат);
		
		// Зафиксируем заголовок отчета
		Если ПараметрыОтчета.ВыводитьЗаголовок Тогда
			ВысотаЗаголовка = Результат.Области.Заголовок.Низ;
			Результат.ФиксацияСверху = ВысотаЗаголовка + 2;
		КонецЕсли;
		
	КонецПроцедуры
	
	
	////////////////////////////////////////////////////////////////////////////////
	// ОБРАБОТЧИКИ СОБЫТИЙ
	
	
	////////////////////////////////////////////////////////////////////////////////
	// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ
	
	
#КонецЕсли