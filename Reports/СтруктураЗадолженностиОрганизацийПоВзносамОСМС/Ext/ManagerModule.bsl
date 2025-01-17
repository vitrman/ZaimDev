﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

////////////////////////////////////////////////////////////////////////////////
// ПРОГРАММНЫЙ ИНТЕРФЕЙС

Функция ПолучитьПараметрыИсполненияОтчета() Экспорт
	
	Возврат Новый Структура("ИспользоватьПередКомпоновкойМакета,
							|ИспользоватьПослеКомпоновкиМакета,
							|ИспользоватьПослеВыводаРезультата,
							|ИспользоватьДанныеРасшифровки,
							|ИспользоватьРасширенныеПараметрыРасшифровки",
							Истина, Ложь, Истина, Истина, Истина);
							
КонецФункции

Функция ПолучитьТекстЗаголовка(ПараметрыОтчета, ОрганизацияВНачале = Истина) Экспорт
	
	ЗаголовокОтчета = НСтр("ru = 'Структура задолженности организаций по взносам ОСМС %1'");
	ЗаголовокОтчета = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
		ЗаголовокОтчета, БухгалтерскиеОтчетыКлиентСервер.ПолучитьПредставлениеПериода(ПараметрыОтчета.НачалоПериода, ПараметрыОтчета.КонецПериода));
	
	Возврат ЗаголовокОтчета;
	
КонецФункции

// В процедуре можно доработать компоновщик перед выводом в отчет
// Изменения сохранены не будут
Процедура ПередКомпоновкойМакета(ПараметрыОтчета, Схема, КомпоновщикНастроек) Экспорт
	
	Если ПараметрыОтчета.РежимРасшифровки Тогда
		КомпоновщикНастроек.Настройки.Выбор.ИдентификаторПользовательскойНастройки = "";
	КонецЕсли;
	
	Если ПараметрыОтчета.Свойство("ОткрытИзРассылки") И ПараметрыОтчета.ОткрытИзРассылки Тогда
		
		КомпоновщикНастроек.Настройки.Структура.ИдентификаторПользовательскойНастройки = "";
		Для Каждого ЭлементСтруктуры Из КомпоновщикНастроек.Настройки.Структура Цикл
			ЭлементСтруктуры.ИдентификаторПользовательскойНастройки = "";
			ОтчетыВызовСервераБК.ОбработатьСтруктуруНастроек(ЭлементСтруктуры);
		КонецЦикла;
		КомпоновщикНастроек.Настройки.Выбор.ИдентификаторПользовательскойНастройки = "";
	КонецЕсли;
	
	КомпоновщикНастроек.Настройки.Структура.Очистить();
	КомпоновщикНастроек.Настройки.Выбор.Элементы.Очистить();
	
	Если ЗначениеЗаполнено(ПараметрыОтчета.НачалоПериода) Тогда
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "НачалоПериода", НачалоДня(ПараметрыОтчета.НачалоПериода));
	Иначе
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "НачалоПериода", Дата(1, 1, 1));
	КонецЕсли;
	Если ЗначениеЗаполнено(ПараметрыОтчета.КонецПериода) Тогда
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "КонецПериода", КонецДня(ПараметрыОтчета.КонецПериода));
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "КонецПериодаОстатков", Новый Граница(КонецДня(ПараметрыОтчета.КонецПериода), ВидГраницы.Включая));
	Иначе
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "КонецПериода", Дата(3999, 11, 1));
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "КонецПериодаОстатков", Новый Граница(КонецДня(Дата(3999, 11, 1)), ВидГраницы.Включая));
	КонецЕсли;
	
	БухгалтерскиеОтчеты.ДобавитьОтборПоОрганизациямИПодразделениям(КомпоновщикНастроек, ПараметрыОтчета);
	
	// определим какие показатели и в каком порядке показывать
	Для Каждого Показатель Из ПараметрыОтчета.Показатели Цикл
		Если Показатель.Использование Тогда
			БухгалтерскиеОтчетыКлиентСервер.ДобавитьВыбранноеПоле(КомпоновщикНастроек, Показатель.Поле);
		КонецЕсли;
	КонецЦикла;
	
	Структура = КомпоновщикНастроек.Настройки.Структура.Добавить(Тип("ГруппировкаКомпоновкиДанных"));
	Первый = Истина;
	Для Каждого ПолеВыбраннойГруппировки Из ПараметрыОтчета.Группировка Цикл 
		Если ПолеВыбраннойГруппировки.Использование Тогда
			Если Не Первый Тогда 
				Структура = Структура.Структура.Добавить(Тип("ГруппировкаКомпоновкиДанных"));
			КонецЕсли;
			Первый = Ложь;
						
			ПолеГруппировки = Структура.ПоляГруппировки.Элементы.Добавить(Тип("ПолеГруппировкиКомпоновкиДанных"));
			ПолеГруппировки.Использование  = Истина;
			ПолеГруппировки.Поле           = Новый ПолеКомпоновкиДанных(ПолеВыбраннойГруппировки.Поле);
			
			Если ТипЗнч(ПолеВыбраннойГруппировки.ТипГруппировки) = Тип("ПеречислениеСсылка.ТипДетализацииСтандартныхОтчетов") Тогда
				Если ПолеВыбраннойГруппировки.ТипГруппировки = Перечисления.ТипДетализацииСтандартныхОтчетов.Иерархия Тогда
					ПолеГруппировки.ТипГруппировки = ТипГруппировкиКомпоновкиДанных.Иерархия;
				ИначеЕсли ПолеВыбраннойГруппировки.ТипГруппировки = Перечисления.ТипДетализацииСтандартныхОтчетов.ТолькоИерархия Тогда
					ПолеГруппировки.ТипГруппировки = ТипГруппировкиКомпоновкиДанных.ТолькоИерархия;
				Иначе
					ПолеГруппировки.ТипГруппировки = ТипГруппировкиКомпоновкиДанных.Элементы;
				КонецЕсли;
			КонецЕсли;
			
			Структура.Выбор.Элементы.Добавить(Тип("АвтоВыбранноеПолеКомпоновкиДанных"));
			Структура.Порядок.Элементы.Добавить(Тип("АвтоЭлементПорядкаКомпоновкиДанных")); 
			
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

Процедура ПослеКомпоновкиМакета(ПараметрыОтчета, МакетКомпоновки) Экспорт
		
	
	
КонецПроцедуры

Процедура ПослеВыводаРезультата(ПараметрыОтчета, Результат) Экспорт
	
	БухгалтерскиеОтчетыВызовСервера.ОбработкаРезультатаОтчета(ПараметрыОтчета.ИдентификаторОтчета, Результат);

КонецПроцедуры

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
	
	Возврат ПараметрыОтчета;
	
КонецФункции


////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ

////////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ

Процедура ЗаполнитьПараметрыРасшифровкиОтчета(Адрес, Расшифровка, ПараметрыРасшифровки) Экспорт
	
	// Инициализируем список мунктов меню
	СписокПунктовМеню = Новый СписокЗначений();
	
	// Заполниим соответствие полей которые мы хотим получить из данных расшифровки
	СоответствиеПолей = Новый Структура();
	ДанныеОтчета = ПолучитьИзВременногоХранилища(Адрес);
	
	ЗначениеРасшифровки = ДанныеОтчета.ДанныеРасшифровки.Элементы[Расшифровка];
	Если ТипЗнч(ЗначениеРасшифровки) = Тип("ЭлементРасшифровкиКомпоновкиДанныхПоля") Тогда
		Для Каждого ПолеРасшифровки ИЗ ЗначениеРасшифровки.ПолучитьПоля() Цикл
			Если ЗначениеЗаполнено(ПолеРасшифровки.Значение) Тогда
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
	
	// Прежде всего интересны данные группировочных полей
	Для Каждого Группировка Из ДанныеОтчета.Объект.Группировка Цикл
		
		Если Группировка.Использование Тогда
			
			СоответствиеПолей.Вставить(Группировка.Поле);
			
		КонецЕсли;
		
	КонецЦикла;
	
	//СоответствиеПолей.Вставить("Период");
		
	// Инициализация пользовательских настроек
	ПользовательскиеНастройки = Новый ПользовательскиеНастройкиКомпоновкиДанных;
	ДополнительныеСвойства = ПользовательскиеНастройки.ДополнительныеСвойства;
	ДополнительныеСвойства.Вставить("РежимРасшифровки"				, Истина);
	ДополнительныеСвойства.Вставить("НачалоПериода"					, ДанныеОтчета.Объект.НачалоПериода);
	ДополнительныеСвойства.Вставить("КонецПериода"					, ДанныеОтчета.Объект.КонецПериода);
	ДополнительныеСвойства.Вставить("СписокСтруктурныхЕдиниц", ДанныеОтчета.Объект.СписокСтруктурныхЕдиниц);
	ДополнительныеСвойства.Вставить("ВыводитьДиаграмму"				, Ложь);
	ДополнительныеСвойства.Вставить("ОчищатьТаблицуГруппировок", 		Истина);
	
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
				// Значение нашлось, помещаем в структуру
				Данные_Расшифровки.Вставить(ЭлементДанных.Ключ, ЗначениеРасшифровки);
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	
	ОтборПоЗначениямРасшифровки = ПользовательскиеНастройки.Элементы.Добавить(Тип("ОтборКомпоновкиДанных"));
	ОтборПоЗначениямРасшифровки.ИдентификаторПользовательскойНастройки = "Отбор";
	
	Для Каждого ЗначениеРасшифровки Из Данные_Расшифровки Цикл
		Если ЗначениеРасшифровки.Ключ <> "Период" Тогда
			БухгалтерскиеОтчетыКлиентСервер.ДобавитьОтбор(ОтборПоЗначениямРасшифровки, ЗначениеРасшифровки.Ключ, ЗначениеРасшифровки.Значение);
		КонецЕсли;
	КонецЦикла;
	
	Группировка = Новый Массив();
	ЕстьГруппировкаПоДокументу = Ложь;
	Для Каждого СтрокаГруппировки Из ДанныеОтчета.Объект.Группировка Цикл
		Если СтрокаГруппировки.Использование Тогда
			
			СтрокаДляРасшифровки = Новый Структура("Использование, Поле, Представление, ТипГруппировки");
			ЗаполнитьЗначенияСвойств(СтрокаДляРасшифровки, СтрокаГруппировки);
			Группировка.Добавить(СтрокаДляРасшифровки);
			
			Если СтрокаГруппировки.Поле = "Регистратор" Тогда
				ЕстьГруппировкаПоДокументу = Истина;
			КонецЕсли;
			
		КонецЕсли;
	КонецЦикла;
	
	Если НЕ ЕстьГруппировкаПоДокументу Тогда
		
		СтрокаДляРасшифровки = Новый Структура();
		СтрокаДляРасшифровки.Вставить("Использование", 	Истина);
		СтрокаДляРасшифровки.Вставить("Поле", 			"Регистратор");
		СтрокаДляРасшифровки.Вставить("Представление", 	"Регистратор");
		СтрокаДляРасшифровки.Вставить("ТипГруппировки", 0);
		
		Группировка.Добавить(СтрокаДляРасшифровки);
		
	КонецЕсли;
	
	ДополнительныеСвойства.Вставить("Группировка", Группировка);
	
	Показатели = Новый Массив;
	
	Для Каждого СтрокаПоказатели Из ДанныеОтчета.Объект.Показатели Цикл
		Если СтрокаПоказатели.Использование 
			И (СтрокаПоказатели.Поле = "Исчислено" 
				ИЛИ СтрокаПоказатели.Поле = "Перечислено" 
				ИЛИ СтрокаПоказатели.Поле = "СальдоНачальное"
				ИЛИ СтрокаПоказатели.Поле = "СальдоКонечное")Тогда
			
			СтрокаДляРасшифровки = Новый Структура("Использование, Поле, Представление, ТипГруппировки");
			ЗаполнитьЗначенияСвойств(СтрокаДляРасшифровки, СтрокаПоказатели);
			Показатели.Добавить(СтрокаДляРасшифровки);
			
		КонецЕсли;
	КонецЦикла;
	
	ДополнительныеСвойства.Вставить("Показатели", Показатели);
	
	СписокПунктовМеню.Добавить("СтруктураЗадолженностиОрганизацийПоВзносамОСМС", "СтруктураЗадолженностиОрганизацийПоВзносамОСМС");
	
	НастройкиРасшифровки = Новый Структура();
	НастройкиРасшифровки.Вставить("СтруктураЗадолженностиОрганизацийПоВзносамОСМС", ПользовательскиеНастройки);
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

#КонецЕсли