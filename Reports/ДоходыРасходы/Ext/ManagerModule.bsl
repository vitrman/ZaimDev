﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

////////////////////////////////////////////////////////////////////////////////
// ПРОГРАММНЫЙ ИНТЕРФЕЙС

Функция ПолучитьПараметрыИсполненияОтчета() Экспорт
	
	Возврат Новый Структура("ИспользоватьПередКомпоновкойМакета,
							|ИспользоватьПриВыводеЗаголовка,
							|ИспользоватьПослеВыводаРезультата,
							|ИспользоватьДанныеРасшифровки,
							|ИспользоватьРасширенныеПараметрыРасшифровки",
							Истина, Истина, Истина, Истина, Истина);
							
КонецФункции

Функция ПолучитьТекстЗаголовка(ПараметрыОтчета, ОрганизацияВНачале = Истина) Экспорт
	
	ТекстОрганизации = БухгалтерскиеОтчетыКлиентСервер.ВыгрузитьСписокВСтроку(ПараметрыОтчета.СписокСтруктурныхЕдиниц,,, Истина);
	
	ЗаголовокОтчета = НСтр("ru = 'Доходы и расходы (прибыль/убыток) %1'");
	ЗаголовокОтчета = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
		ЗаголовокОтчета, БухгалтерскиеОтчетыКлиентСервер.ПолучитьПредставлениеПериода(ПараметрыОтчета.НачалоПериода, ПараметрыОтчета.КонецПериода));
		
	Если ОрганизацияВНачале Тогда
		ЗаголовокОтчета = ТекстОрганизации + Символы.ПС + ЗаголовокОтчета;
	Иначе
		ЗаголовокОтчета = ЗаголовокОтчета + " " + ТекстОрганизации;
	КонецЕсли;
	
	Возврат ЗаголовокОтчета;
	
КонецФункции

Процедура ПриВыводеЗаголовка(ПараметрыОтчета, Результат) Экспорт
	
	МакетЗаголовок   = ПолучитьОбщийМакет("ЗаголовокОтчета");
	ОбластьЗаголовок = МакетЗаголовок.ПолучитьОбласть("Заголовок");
	
	ОбластьЗаголовок.Параметры.ЗаголовокОтчета = ПолучитьТекстЗаголовка(ПараметрыОтчета);
	
	Результат.Вывести(ОбластьЗаголовок);
	
КонецПроцедуры

// В процедуре можно доработать компоновщик перед выводом в отчет
// Изменения сохранены не будут
Процедура ПередКомпоновкойМакета(ПараметрыОтчета, Схема, КомпоновщикНастроек) Экспорт

	Если ПараметрыОтчета.РежимРасшифровки
		ИЛИ (ПараметрыОтчета.Свойство("ОткрытИзРассылки") И ПараметрыОтчета.ОткрытИзРассылки) Тогда
		
		КомпоновщикНастроек.Настройки.Структура.ИдентификаторПользовательскойНастройки = "";
		Для Каждого ЭлементСтруктуры Из КомпоновщикНастроек.Настройки.Структура Цикл
			ЭлементСтруктуры.ИдентификаторПользовательскойНастройки = "";
			ОтчетыВызовСервераБК.ОбработатьСтруктуруНастроек(ЭлементСтруктуры);
		КонецЦикла;
	КонецЕсли;
	
	Периодичность = БухгалтерскиеОтчетыКлиентСервер.ПолучитьЗначениеПериодичности(ПараметрыОтчета.Периодичность, ПараметрыОтчета.НачалоПериода, ПараметрыОтчета.КонецПериода);
	ТипДополнения = БухгалтерскиеОтчетыВызовСервера.ПолучитьТипДополненияПоИнтервалу(Периодичность);
	
	БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "Периодичность", Периодичность);
	БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "НачалоПериода", ПараметрыОтчета.НачалоПериода);
	БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "КонецПериода",  КонецДня(ПараметрыОтчета.КонецПериода));
	
	СписокЗакрытияИтогов = Новый СписокЗначений;
	СписокЗакрытияИтогов.Добавить(ПланыСчетов.Типовой.НераспределеннаяПрибыльНепокрытыйУбытокОтчетногоГода);
	СписокЗакрытияИтогов.Добавить(ПланыСчетов.Типовой.ИтоговаяПрибыльИтоговыйУбыток);
	БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек,"СчетаЗакрытия", СписокЗакрытияИтогов);
		
	Таблица   = Неопределено;
	Диаграмма = Неопределено;
	Для Каждого ЭлементСтруктуры Из КомпоновщикНастроек.Настройки.Структура Цикл		
		Если ЭлементСтруктуры.Имя = "Таблица" Тогда
			Таблица = ЭлементСтруктуры;
		ИначеЕсли ЭлементСтруктуры.Имя = "Диаграмма" Тогда
			Диаграмма = ЭлементСтруктуры;
		КонецЕсли;		
	КонецЦикла;
	
	ВыводитьДиаграмму = ПараметрыОтчета.ВыводитьДиаграмму;
	
	Если Диаграмма <> Неопределено Тогда
		
		Если ВыводитьДиаграмму Тогда
			
			Диаграмма.Точки.Очистить();
			ГруппировкаПериод = Диаграмма.Точки.Добавить();
			ПолеГруппировки = ГруппировкаПериод.ПоляГруппировки.Элементы.Добавить(Тип("ПолеГруппировкиКомпоновкиДанных"));
			ПолеГруппировки.Использование = Истина;
			ПолеГруппировки.Поле          = Новый ПолеКомпоновкиДанных("Период");
			ПолеГруппировки.ТипДополнения = ТипДополнения;
			ПолеГруппировки.НачалоПериода =	НачалоДня(ПараметрыОтчета.НачалоПериода);
			ПолеГруппировки.КонецПериода  = КонецДня(ПараметрыОтчета.КонецПериода);
			
			ГруппировкаПериод.Выбор.Элементы.Добавить(Тип("АвтоВыбранноеПолеКомпоновкиДанных"));
			ГруппировкаПериод.Порядок.Элементы.Добавить(Тип("АвтоЭлементПорядкаКомпоновкиДанных"));
			
			// Группировка
			Диаграмма.Серии.Очистить();
			Для Каждого ПолеВыбраннойГруппировки Из ПараметрыОтчета.Группировка Цикл 
				Если ПолеВыбраннойГруппировки.Использование Тогда
					Группировка = Диаграмма.Серии.Добавить();
					БухгалтерскиеОтчетыВызовСервера.ЗаполнитьГруппировку(ПолеВыбраннойГруппировки, Группировка);				
					Прервать;
				КонецЕсли;
			КонецЦикла;
			
		Иначе
			
			Диаграмма.Использование = ВыводитьДиаграмму;
			
		КонецЕсли;
	
	КонецЕсли;
	
	Если Таблица <> Неопределено Тогда
		Таблица.Колонки.Очистить();
		ГруппировкаПериод = Таблица.Колонки.Добавить();
		ГруппировкаПериод.Имя = "Период";
		ПолеГруппировки = ГруппировкаПериод.ПоляГруппировки.Элементы.Добавить(Тип("ПолеГруппировкиКомпоновкиДанных"));
		ПолеГруппировки.Использование = Истина;
		ПолеГруппировки.Поле          = Новый ПолеКомпоновкиДанных("Период");
		ПолеГруппировки.НачалоПериода =	НачалоДня(ПараметрыОтчета.НачалоПериода);
		ПолеГруппировки.КонецПериода  = КонецДня(ПараметрыОтчета.КонецПериода);
		
		ГруппировкаПериод.Выбор.Элементы.Добавить(Тип("АвтоВыбранноеПолеКомпоновкиДанных"));
		ГруппировкаПериод.Порядок.Элементы.Добавить(Тип("АвтоЭлементПорядкаКомпоновкиДанных"));
		
		// Группировка
		Таблица.Строки.Очистить();
		Группировка = Таблица.Строки;
		Для Каждого ПолеВыбраннойГруппировки Из ПараметрыОтчета.Группировка Цикл 
			Если ПолеВыбраннойГруппировки.Использование Тогда
				Если ТипЗнч(Группировка) = Тип("КоллекцияЭлементовСтруктурыТаблицыКомпоновкиДанных") Тогда
					Группировка = Группировка.Добавить();
				Иначе
					Группировка = Группировка.Структура.Добавить();
				КонецЕсли;
				БухгалтерскиеОтчетыВызовСервера.ЗаполнитьГруппировку(ПолеВыбраннойГруппировки, Группировка);				
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	
	// Дополнительные данные
	БухгалтерскиеОтчетыВызовСервера.ДобавитьДополнительныеПоля(ПараметрыОтчета, КомпоновщикНастроек);
	
	БухгалтерскиеОтчеты.ДобавитьОтборПоОрганизациямИПодразделениям(КомпоновщикНастроек, ПараметрыОтчета);

	//КомпоновщикНастроек.Инициализировать(Новый ИсточникДоступныхНастроекКомпоновкиДанных(Схема));
	
КонецПроцедуры

Процедура ПослеВыводаРезультата(ПараметрыОтчета, Результат) Экспорт
	
	БухгалтерскиеОтчетыВызовСервера.ОбработкаРезультатаОтчета(ПараметрыОтчета.ИдентификаторОтчета, Результат);
	
	Для Каждого Рисунок Из Результат.Рисунки Цикл
		Для Каждого Серия Из Рисунок.Объект.Серии Цикл
			Если Серия.Текст = НСтр("ru = 'Доходы без НДС'")
				ИЛИ Серия.Текст = НСтр("ru = 'Расходы'") Тогда
				Серия.Индикатор = Истина;
			КонецЕсли;
		КонецЦикла;
	КонецЦикла;

КонецПроцедуры

Процедура ЗаполнитьПараметрыРасшифровкиОтчета(Адрес, Расшифровка, ПараметрыРасшифровки) Экспорт
	
	// Инициализируем список мунктов меню
	СписокПунктовМеню = Новый СписокЗначений();
	
	// Заполниим соответствие полей которые мы хотим получить из данных расшифровки
	СоответствиеПолей = Новый Структура();
	ДанныеОтчета = ПолучитьИзВременногоХранилища(Адрес);
	
	ЗначениеРасшифровки = ДанныеОтчета.ДанныеРасшифровки.Элементы[Расшифровка];
	Если ТипЗнч(ЗначениеРасшифровки) = Тип("ЭлементРасшифровкиКомпоновкиДанныхПоля") Тогда
		Для Каждого ПолеРасшифровки ИЗ ЗначениеРасшифровки.ПолучитьПоля() Цикл
			Если ЗначениеЗаполнено(ПолеРасшифровки.Значение) И ПолеРасшифровки.Значение <> "Показатель" Тогда
				ПараметрыРасшифровки.Вставить("ОткрытьОбъект", Истина);
				ПараметрыРасшифровки.Вставить("Значение",  ПолеРасшифровки.Значение);
				Возврат;
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	
	// Укажем что открывать объект сразу не нужно
	ПараметрыРасшифровки.Вставить("ОткрытьОбъект", Ложь);
	
	Если ДанныеОтчета = Неопределено Тогда 
		ПараметрыРасшифровки.Вставить("СписокПунктовМеню", СписокПунктовМеню);
		Возврат;
	КонецЕсли;
	
	КомпоновщикНастроек = Новый КомпоновщикНастроекКомпоновкиДанных;
	КомпоновщикНастроек.ЗагрузитьНастройки(ДанныеОтчета.ДанныеРасшифровки.Настройки);
	КомпоновщикНастроек.Инициализировать(Новый ИсточникДоступныхНастроекКомпоновкиДанных(ДанныеОтчета.Объект.СхемаКомпоновкиДанных));
	
	МассивПолей = БухгалтерскиеОтчетыВызовСервера.ПолучитьМассивПолейРасшифровки(Расшифровка, ДанныеОтчета.ДанныеРасшифровки, КомпоновщикНастроек, Истина);
	
	Показатель = "";
	Для Каждого ПолеРасшифровки Из МассивПолей Цикл
		Если ТипЗнч(ПолеРасшифровки) = Тип("ЗначениеПоляРасшифровкиКомпоновкиДанных")
			И ПолеРасшифровки.Значение = "Показатель" Тогда
			Показатель = ПолеРасшифровки.Поле;
			Прервать;
		КонецЕсли;
	КонецЦикла;
	
	// Прежде всего интересны данные группировочных полей
	Для Каждого Группировка Из ДанныеОтчета.Объект.Группировка Цикл
		Если Группировка.Использование Тогда
			СоответствиеПолей.Вставить(Группировка.Поле);
		КонецЕсли;
	КонецЦикла;
	
	СоответствиеПолей.Вставить("Период");
	СоответствиеПолей.Вставить("Показатель");
	СоответствиеПолей.Вставить("Счет");
		
	// Инициализация пользовательских настроек
	ПользовательскиеНастройки = Новый ПользовательскиеНастройкиКомпоновкиДанных;
	ДополнительныеСвойства = ПользовательскиеНастройки.ДополнительныеСвойства;
	ДополнительныеСвойства.Вставить("РежимРасшифровки",  Истина);
	ДополнительныеСвойства.Вставить("НачалоПериода",     ДанныеОтчета.Объект.НачалоПериода);
	ДополнительныеСвойства.Вставить("КонецПериода",      ДанныеОтчета.Объект.КонецПериода);
	ДополнительныеСвойства.Вставить("ВыводитьЗаголовок", ДанныеОтчета.Объект.ВыводитьЗаголовок);
	ДополнительныеСвойства.Вставить("ВыводитьПодписи",   ДанныеОтчета.Объект.ВыводитьПодписи);
	ДополнительныеСвойства.Вставить("МакетОформления",   ДанныеОтчета.Объект.МакетОформления);
	ДополнительныеСвойства.Вставить("Периодичность",     ДанныеОтчета.Объект.Периодичность);
	ДополнительныеСвойства.Вставить("ВыводитьДиаграмму", Ложь);
	ДополнительныеСвойства.Вставить("ПоказательБУ",      Истина);
	ДополнительныеСвойства.Вставить("СписокСтруктурныхЕдиниц", ДанныеОтчета.Объект.СписокСтруктурныхЕдиниц);
	
	// Получаем соответствие полей доступных в расшифровке
	Данные_Расшифровки = Новый Соответствие();
	
	Если ДанныеОтчета.ДанныеРасшифровки <> Неопределено Тогда
		// Ищем интересующие нас поля в заданной расшифровке
		Для каждого ЭлементДанных Из СоответствиеПолей Цикл
			// Получаем элемент расшифровки, в котором нужно искать поля
			Родитель = ДанныеОтчета.ДанныеРасшифровки.Элементы[Расшифровка];
			// Вызываем рекурсивный поиск поля
			ЗначениеРасшифровки = ПолучитьЗначениеРасшифровки(Родитель, ЭлементДанных.Ключ);
			Если ЗначениеРасшифровки <> Неопределено Тогда
				Данные_Расшифровки.Вставить(ЭлементДанных.Ключ, ЗначениеРасшифровки);
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	
	Счет = Данные_Расшифровки.Получить("Счет");
	ЕстьСчет = ДанныеОтчета.Объект.Группировка.Найти("Счет", "Поле") <> Неопределено;
	
	Если ДанныеОтчета.Объект.РежимРасшифровки Тогда
		Если Счет = Неопределено И ЕстьСчет Тогда
			ТекстСообщения = НСтр("ru = 'Расшифровка невозможна. Неизвестен счет.'");
			ОбщегоНазначения.СообщитьПользователю(ТекстСообщения);
			ПараметрыРасшифровки.Вставить("СписокПунктовМеню", СписокПунктовМеню);
			Возврат;
		ИначеЕсли Счет <> Неопределено И ЕстьСчет Тогда
			СписокПунктовМеню.Добавить("АнализСчетаТиповой", НСтр("ru = 'Анализ счета (бух.)'"));
			ИДРасшифровки = "АнализСчетаТиповой";
		Иначе
			СписокПунктовМеню.Добавить("ДоходыРасходы", НСтр("ru = 'Доходы и расходы (прибыль и убыток)'"));
			ИДРасшифровки = "ДоходыРасходы";
		КонецЕсли;
	Иначе
		СписокПунктовМеню.Добавить("ДоходыРасходы", НСтр("ru = 'Доходы и расходы (прибыль и убыток)'"));
		ИДРасшифровки = "ДоходыРасходы";
	КонецЕсли;
	
	Если Счет <> Неопределено Тогда
		ДанныеСчета = ПроцедурыБухгалтерскогоУчетаВызовСервераПовтИсп.ПолучитьСвойстваСчета(Счет);
	Иначе
		ДанныеСчета = Неопределено;
	КонецЕсли;
	
	Период = Данные_Расшифровки.Получить("Период");
	
	Если ЗначениеЗаполнено(Период) Тогда
		Периодичность = БухгалтерскиеОтчетыКлиентСервер.ПолучитьЗначениеПериодичности(ДанныеОтчета.Объект.Периодичность, ДанныеОтчета.Объект.НачалоПериода, ДанныеОтчета.Объект.КонецПериода);
		ДополнительныеСвойства.Вставить("Периодичность", Периодичность);
		ДополнительныеСвойства.Вставить("КонецПериода" , КонецДня(БухгалтерскиеОтчетыКлиентСервер.КонецПериода(Период, Периодичность)));
		ДополнительныеСвойства.Вставить("НачалоПериода", НачалоДня(БухгалтерскиеОтчетыКлиентСервер.НачалоПериода(Период, Периодичность)));
	КонецЕсли;
	
	ОтборПоЗначениямРасшифровки = ПользовательскиеНастройки.Элементы.Добавить(Тип("ОтборКомпоновкиДанных"));
	ОтборПоЗначениямРасшифровки.ИдентификаторПользовательскойНастройки = "Отбор";
	
	Для Каждого ЗначениеРасшифровки Из Данные_Расшифровки Цикл
		Если ЗначениеРасшифровки.Ключ <> "Период" Тогда
			Если ИДРасшифровки = "АнализСчетаТиповой" Тогда
				Если ЗначениеРасшифровки.Ключ = "Счет" Тогда
					ДополнительныеСвойства.Вставить("Счет",	ЗначениеРасшифровки.Значение);
				ИначеЕсли ЗначениеРасшифровки.Ключ <> "Вид" Тогда
					ПолеОтбора = Неопределено;
					Если ДанныеСчета <> Неопределено И ДанныеСчета.КоличествоСубконто > 0 Тогда
						Для НомерСубконто = 1 По ДанныеСчета.КоличествоСубконто Цикл
							Если ДанныеСчета["ВидСубконто" + НомерСубконто + "ТипЗначения"].СодержитТип(ТипЗнч(ЗначениеРасшифровки.Значение)) Тогда
								ПолеОтбора = "Субконто" + НомерСубконто;
							КонецЕсли;
						КонецЦикла;
					КонецЕсли;
					Если ПолеОтбора = Неопределено Тогда
						ПолеОтбора = ЗначениеРасшифровки.Ключ;
					КонецЕсли;
					БухгалтерскиеОтчетыКлиентСервер.ДобавитьОтбор(ОтборПоЗначениямРасшифровки, ПолеОтбора, ЗначениеРасшифровки.Значение);
				КонецЕсли;
			Иначе
				БухгалтерскиеОтчетыКлиентСервер.ДобавитьОтбор(ОтборПоЗначениямРасшифровки, ЗначениеРасшифровки.Ключ, ЗначениеРасшифровки.Значение);
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
	
	Группировка = Новый Массив();
	Для Каждого СтрокаГруппировки Из ДанныеОтчета.Объект.Группировка Цикл
		Если СтрокаГруппировки.Использование Тогда
			СтрокаДляРасшифровки = Новый Структура("Использование, Поле, Представление, ТипГруппировки");
			ЗаполнитьЗначенияСвойств(СтрокаДляРасшифровки, СтрокаГруппировки);
			Группировка.Добавить(СтрокаДляРасшифровки);
		КонецЕсли;
	КонецЦикла;
	
	ГруппировкаСчет = Новый Структура("Использование, Поле, Представление, ТипГруппировки",
	                                   Истина, "Счет", "Счет", Перечисления.ТипДетализацииСтандартныхОтчетов.Элементы);

	Если ИДРасшифровки = "ДоходыРасходы" Тогда
	    Группировка.Добавить(ГруппировкаСчет);
	Иначе
	    Группировка.Вставить(0, ГруппировкаСчет);
	КонецЕсли;

	ДополнительныеСвойства.Вставить("Группировка", Группировка);
	
	НастройкиРасшифровки = Новый Структура();
	НастройкиРасшифровки.Вставить(ИДРасшифровки , ПользовательскиеНастройки);
	ДанныеОтчета.Вставить("НастройкиРасшифровки", НастройкиРасшифровки);
	
	ПоместитьВоВременноеХранилище(ДанныеОтчета, Адрес);
	
	ПараметрыРасшифровки.Вставить("СписокПунктовМеню", СписокПунктовМеню);
	
КонецПроцедуры

// Возвращает значение искомого поля из элемента расшифровки.
//
Функция ПолучитьЗначениеРасшифровки(Элемент, ИмяПоля)
	
	Если ТипЗнч(Элемент) = Тип("ЭлементРасшифровкиКомпоновкиДанныхПоля") Тогда
		// Ищем поля в текущем элементе
		Поле = Элемент.ПолучитьПоля().Найти(ИмяПоля);
		Если Поле <> Неопределено Тогда
			// Возвращаем значение найденного поля
			Возврат Поле.Значение;
		КонецЕсли;
	КонецЕсли;
	
	// Если поле не нашлось, или текущий элемент не содержит полей
	// ищем поля среди родителей элемента (вышестоящие группировки).
	Родители  = Элемент.ПолучитьРодителей();
	Если Родители.Количество() > 0 Тогда
		
		Для Каждого Родитель Из Родители Цикл
			// Вызываем рекурсивный поиск поля
			ЗначениеРасшифровки = ПолучитьЗначениеРасшифровки(Родитель, ИмяПоля);
			
			Если ЗначениеРасшифровки <> Неопределено Тогда
				Возврат ЗначениеРасшифровки;
			КонецЕсли;
			
		КонецЦикла;
	КонецЕсли;
	
	// Если ничего не нашлось
	Возврат Неопределено;
	
КонецФункции

Процедура НастроитьВариантыОтчета(Настройки, НастройкиОтчета) Экспорт
	
	НастройкиОтчета.ОпределитьНастройкиФормы = Истина;
	
	Схема = ПолучитьМакет("ОсновнаяСхемаКомпоновкиДанных");
	Для Каждого Вариант из Схема.ВариантыНастроек Цикл
		НастройкиВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, НастройкиОтчета, Вариант.Имя);
	КонецЦикла;
	
КонецПроцедуры

// Возвращает структуру параметров, наличие которых требуется для успешного формирования отчета.
//
// Возвращаемое значение:
//   Структура - структура параметров для формирования отчета.
//
Функция ПустыеПараметрыКомпоновкиОтчета() Экспорт
	
	ПараметрыОтчета = РассылкаОтчетовБК.НастройкиОтчетаСохраняемыеВРассылке();
	ПараметрыОтчета.Вставить("ВыводитьДиаграмму", Истина);
	
	Возврат ПараметрыОтчета;
	
КонецФункции

#КонецЕсли