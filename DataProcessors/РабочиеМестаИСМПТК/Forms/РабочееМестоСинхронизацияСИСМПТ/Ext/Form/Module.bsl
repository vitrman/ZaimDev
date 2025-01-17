﻿////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ФОРМЫ

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	РежимЗапуска = Параметры.РежимЗапуска;
	ВидыДокументов = "Акты"; //по умолчанию
	Если Параметры.Свойство("ВидыДокументов") И ЗначениеЗаполнено(Параметры.ВидыДокументов) Тогда
		ВидыДокументов = Параметры.ВидыДокументов;
	КонецЕсли;
	
	ОрганизацияОтбор = ?(Параметры.Свойство("ОрганизацияОтбор"), Параметры.ОрганизацияОтбор, Неопределено);
	ЗаполнитьТаблицуПрофилейДляСинхронизации(ОрганизацияОтбор);
	
	УправлениеФормой();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	Контейнер = ИнтеграцияИСМПТККлиентСервер.КонтейнерМетодов();	
	Контейнер.ПриОткрытииФормы(ЭтаФорма, Отказ);
	Если Отказ Тогда
		Возврат;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ТаблицаСтруктурнаяЕдиницаОчистка(Элемент, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
КонецПроцедуры

&НаКлиенте
Процедура ТаблицаСтруктурнаяЕдиницаПриИзменении(Элемент)
	
	Строка = Элементы.Таблица.ТекущиеДанные;
	Строка.Пометка = Истина;
	Строка.ДатаОкончанияСинхронизацииИСМПТ = КонецДня(ПолучитьТекущуюДату());
	
КонецПроцедуры

&НаСервере
Функция ПолучитьТекущуюДату() Экспорт
	
	Возврат ТекущаяДатаСеанса();
	
КонецФункции

&НаКлиенте
Процедура ТаблицаПрофильИСМПТНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
КонецПроцедуры

&НаКлиенте
Процедура ТаблицаПрофильИСМПТОчистка(Элемент, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
КонецПроцедуры

&НаКлиенте
Процедура ТаблицаКомментарийОчистка(Элемент, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ КОМАНД ФОРМЫ
    
&НаКлиенте
Процедура Синхронизировать(Команда)
	
	// Создать массив профилей ИС МПТ из помеченных строк таблицы.
	МассивПрофилейИСМПТСДатойСинхронизации = Новый Массив; 
	СтруктурныеЕдиницы = Новый Соответствие;
	//
	Для Каждого СтрокаТаблицы Из Таблица Цикл
		
		Если СтрокаТаблицы.Пометка Тогда
			
			ТокенАвторизации = ПолучитьТокенАвторизации(СтрокаТаблицы.СтруктурнаяЕдиница);
			
			Если ТокенАвторизации = Неопределено Тогда
				
				ТекстСообщенияТокенНеПолучен = НСтр("ru='Операция прервана: не получены данные ЭЦП.'");
				ИнтеграцияИСМПТККлиентСерверПереопределяемый.СообщитьПользователю(ТекстСообщенияТокенНеПолучен);
				Возврат;
				
			КонецЕсли;
			
			ДанныеСтрокиАвторизации  = Новый Структура();
			ДанныеСтрокиАвторизации.Вставить("СтруктурнаяЕдиница", СтрокаТаблицы.СтруктурнаяЕдиница);
			ДанныеСтрокиАвторизации.Вставить("ПрофильИСМПТ", 	   СтрокаТаблицы.ПрофильИСМПТ);
			ДанныеСтрокиАвторизации.Вставить("ДатаНачалаСинхронизацииВходящихДокументовИСМПТ", СтрокаТаблицы.ДатаНачалаСинхронизацииИСМПТ);
			ДанныеСтрокиАвторизации.Вставить("ДатаОкончанияСинхронизацииИСМПТ", 			   СтрокаТаблицы.ДатаОкончанияСинхронизацииИСМПТ);
			ДанныеСтрокиАвторизации.Вставить("ТокенАвторизации",    ТокенАвторизации);
			//виды получаемых документов
			//	"Акты" - акты приема-передачи и уведомления о расхождении
			//	"УведомленияОВвозе" - уведомления о ввозе из ЕАЭС
			//	"УведомленияОВвозеИмпорт" - уведомления о ввозе из третьих стран
			//  "УведомлениеОбОтгрузкеЕАЭС"
			ДанныеСтрокиАвторизации.Вставить("ВидыДокументов", ВидыДокументов);
			
			МассивПрофилейИСМПТСДатойСинхронизации.Добавить(ДанныеСтрокиАвторизации);
			СтруктурныеЕдиницы.Вставить(СтрокаТаблицы.СтруктурнаяЕдиница, "");
			
		КонецЕсли;
	КонецЦикла;
	
	//Проверка заполненности формы получения данных.
	Если МассивПрофилейИСМПТСДатойСинхронизации.Количество() = 0 Тогда
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = НСтр("ru = 'Выберите хотя бы одну настройку для синхронизации с ИС МПТ.'");
		Сообщение.Поле = "Таблица";
		Сообщение.Сообщить();
		Возврат;
	КонецЕсли;
	
	ЕстьПроблемные = Ложь;
	Для Каждого Настройка Из МассивПрофилейИСМПТСДатойСинхронизации Цикл
		Если Настройка.ДатаНачалаСинхронизацииВходящихДокументовИСМПТ = Дата("00010101") Тогда
			ТекстСообщения = НСтр("ru = 'Укажите начальную дату периода синхронизации с ИС МПТ для структурной единицы %1.'");
			ТекстСообщения = ИнтеграцияИСМПТККлиентСерверПереопределяемый.ПодставитьПараметрыВСтроку(ТекстСообщения, Настройка.СтруктурнаяЕдиница); 
			Сообщение = Новый СообщениеПользователю;
			Сообщение.Текст = ТекстСообщения;
			Сообщение.Поле = "Таблица";
			Сообщение.Сообщить();
			ЕстьПроблемные = Истина;
		КонецЕсли;
	КонецЦикла;
	Если ЕстьПроблемные Тогда
		Возврат;
	КонецЕсли;

	ДополнительныеПараметры = Новый Структура("МассивПрофилейИСМПТСДатойСинхронизации", МассивПрофилейИСМПТСДатойСинхронизации);
	ПараметрыФормы = Новый Структура("СписокСтруктурныхЕдиниц, ТребуетсяВыборСертификата", СтруктурныеЕдиницы, Истина);
	ПараметрыФормы.Вставить("ТребуетсяВыборСертификата", Истина);
		
	СинхронизироватьИСМПТ(ПараметрыФормы, ДополнительныеПараметры);
	
КонецПроцедуры

&НаКлиенте
Процедура СинхронизироватьИСМПТ(МассивДанныхАвторизации, ДополнительныеПараметры) Экспорт
	
	Если МассивДанныхАвторизации.Свойство("СписокСтруктурныхЕдиниц") = Неопределено Тогда
		Возврат;
	КонецЕсли;

	РезультатРаботыЗадания = СинхронизироватьИСМПТСервер(МассивДанныхАвторизации, ДополнительныеПараметры);
	
	//оповестить формы списка
	ИнтеграцияИСМПТККлиент.ОповеститьФормы(ИнтеграцияИСМПТККлиентСервер.ИмяСобытияЗаписьАктПриемаПередачи());
	ИнтеграцияИСМПТККлиент.ОповеститьФормы(ИнтеграцияИСМПТККлиентСервер.ИмяСобытияЗаписьУведомлениеОРасхождении());
	ИнтеграцияИСМПТККлиент.ОповеститьФормы(ИнтеграцияИСМПТККлиентСервер.ИмяСобытияЗаписьУведомлениеОВвозеИзЕАЭС());
	ИнтеграцияИСМПТККлиент.ОповеститьФормы(ИнтеграцияИСМПТККлиентСервер.ИмяСобытияЗаписьУведомлениеОВвозеИзТретьихСтран());
	ИнтеграцияИСМПТККлиент.ОповеститьФормы(ИнтеграцияИСМПТККлиентСервер.ИмяСобытияЗаписьУведомлениеОбОтгрузкеЕАЭС());
	ИнтеграцияИСМПТККлиент.ОповеститьФормы(ИнтеграцияИСМПТККлиентСервер.ИмяСобытияСинхронизацияИСМПТ());
		
КонецПроцедуры

&НаСервере
Функция СинхронизироватьИСМПТСервер(Параметры, ДополнительныеПараметры) Экспорт
	
	Возврат ИнтерфейсИСМПТК.ПолучитьНовыеДокументыИСМПТ(Параметры, ДополнительныеПараметры);
	
КонецФункции

&НаКлиенте
Процедура УстановитьФлажки(Команда)	
	Для Каждого СтрокаТаблицы Из Таблица Цикл
		СтрокаТаблицы.Пометка = Истина;
	КонецЦикла;	
КонецПроцедуры

&НаКлиенте
Процедура СнятьФлажки(Команда)
	Для Каждого СтрокаТаблицы Из Таблица Цикл
		СтрокаТаблицы.Пометка = Ложь;
	КонецЦикла;
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ

&НаСервере
Процедура ЗаполнитьТаблицуПрофилейДляСинхронизации(ОрганизацияОтбор = Неопределено)
	
	// Запрос организован таким образом, чтобы сработал RLS.
		
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	Организации.Ссылка КАК СтруктурнаяЕдиница,
	|	Организации.Наименование
	|ПОМЕСТИТЬ СтруктурныеЕдиницы
	|ИЗ
	|	Справочник.Организации КАК Организации
	|
	| [ЗапросПоСтруктурнымЕдиницам]
	|/////////////////////////////////////
	|;
	|
	|ВЫБРАТЬ
	|	СтруктурныеЕдиницы.СтруктурнаяЕдиница,
	|	ЕСТЬNULL(ПараметрыМетодовИСМПТК.ЗначениеПараметра, &ДатаПоУмолчанию) КАК ДатаНачалаСинхронизацииИСМПТ
	|ИЗ
	|	СтруктурныеЕдиницы КАК СтруктурныеЕдиницы
	|ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.ПараметрыМетодовИСМПТК КАК ПараметрыМетодовИСМПТК
	|		ПО (СтруктурныеЕдиницы.СтруктурнаяЕдиница = ПараметрыМетодовИСМПТК.СтруктурнаяЕдиница
	|				И ПараметрыМетодовИСМПТК.ИмяМетода = &ИмяМетода
	//|				И ПараметрыМетодовИСМПТК.Направление = &Направление
	|				И ПараметрыМетодовИСМПТК.ИмяПараметра = &ИмяПараметра)
	|
	|
	|УПОРЯДОЧИТЬ ПО
	|	СтруктурныеЕдиницы.СтруктурнаяЕдиница.Наименование";
	
	// Не все конфигурации поддерживают структурные единицы.
	Если ИнтеграцияИСМПТККлиентСерверПереопределяемый.ИспользуютсяСтруктурныеПодразделения() Тогда
		ЗапросПоСтруктурнымЕдиницам = 
		"ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	ПодразделенияОрганизаций.Ссылка,
		|	ПодразделенияОрганизаций.Наименование
		|ИЗ
		|	Справочник.ПодразделенияОрганизаций КАК ПодразделенияОрганизаций
		|ГДЕ
		|	ПодразделенияОрганизаций.ЯвляетсяСтруктурнымПодразделением";		
	Иначе
		ЗапросПоСтруктурнымЕдиницам = "";
	КонецЕсли;	
	
	Запрос.Текст = СтрЗаменить(Запрос.Текст, "[ЗапросПоСтруктурнымЕдиницам]", ЗапросПоСтруктурнымЕдиницам);
	ДатаНачалаПоУмолчанию = Дата(2020, 1, 1, 0, 0, 0);
	ДатаОкончания = ТекущаяДатаСеанса();
	Запрос.УстановитьПараметр("ИмяМетода",		 ИнтеграцияИСМПТК.ИмяМетодаДляВидаДокументов(ВидыДокументов));
	Запрос.УстановитьПараметр("ИмяПараметра", 	 "create_from");
	Запрос.УстановитьПараметр("Направление", 	 Перечисления.НаправленияДокументовИСМПТК.ПустаяСсылка());
	Запрос.УстановитьПараметр("ДатаПоУмолчанию", ДатаНачалаПоУмолчанию);
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл
		СтрокаТаблицы = Таблица.Добавить();
		ЗаполнитьЗначенияСвойств(СтрокаТаблицы, Выборка);
		СтрокаТаблицы.ДатаОкончанияСинхронизацииИСМПТ = ДатаОкончания;
	КонецЦикла;
	
	Если ЗначениеЗаполнено(ОрганизацияОтбор) Тогда
		Если ЭтотОбъект.Таблица.Количество() = 0 Тогда
			//Предзаполняем таблицу 
			НоваяСтрока = ЭтотОбъект.Таблица.Добавить();
			НоваяСтрока.Пометка = Истина;
			НоваяСтрока.СтруктурнаяЕдиница = ОрганизацияОтбор;
			НоваяСтрока.ДатаОкончанияСинхронизацииИСМПТ = ДатаОкончания;
		Иначе
			НайденныеСтроки = ЭтотОбъект.Таблица.НайтиСтроки(Новый Структура("СтруктурнаяЕдиница", ОрганизацияОтбор));
			Для каждого СтрокаТаблицы Из НайденныеСтроки Цикл
				СтрокаТаблицы.Пометка = Истина;
			КонецЦикла;
			Если НайденныеСтроки.Количество() = 0 Тогда
				НоваяСтрока = ЭтотОбъект.Таблица.Добавить();
				НоваяСтрока.Пометка = Истина;
				НоваяСтрока.СтруктурнаяЕдиница = ОрганизацияОтбор;
				НоваяСтрока.ДатаОкончанияСинхронизацииИСМПТ = ДатаОкончания;
			КонецЕсли;
		КонецЕсли;
	Иначе
		Если ЭтотОбъект.Таблица.Количество() = 1 Тогда
			ЭтотОбъект.Таблица[0].Пометка = Истина;
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьТаблицуПрофилейДляСинхронизации()
	
	МассивПрофилейИСМПТ = Новый Массив;
	
	Для Каждого СтрокаТаблицы Из Таблица Цикл
		Если СтрокаТаблицы.Пометка Тогда
			МассивПрофилейИСМПТ.Добавить(СтрокаТаблицы.ПрофильИСМПТ);				
		КонецЕсли;
	КонецЦикла;
	
	Таблица.Очистить();
	ЗаполнитьТаблицуПрофилейДляСинхронизации();
		
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = ИнтеграцияИСМПТККлиентСервер.ИмяСобытияСинхронизацияИСМПТ() Тогда
		ОбновитьТаблицуПрофилейДляСинхронизации(); // Обновление даты синхронизации по результататм работы события
	КонецЕсли;	
	
КонецПроцедуры

&НаСервере
Процедура УправлениеФормой()
	
	Элементы.ДекорацияПояснение.Видимость = Истина;
	Если ВидыДокументов = "Акты" Тогда
		Элементы.ДекорацияПояснение.Заголовок = нСтр("ru='Получение документов Акты приема/передачи и Уведомления о расхождениях'", "ru");
		
	ИначеЕсли ВидыДокументов = "УведомленияОВвозе" Тогда
		Элементы.ДекорацияПояснение.Заголовок = нСтр("ru='Получение документов Уведомления о ввозе товаров (ЕАЭС)'", "ru");
		
	ИначеЕсли ВидыДокументов = "УведомленияОВвозеИмпорт" Тогда
		Элементы.ДекорацияПояснение.Заголовок = нСтр("ru='Получение документов Уведомления о ввозе товаров (импорт)'", "ru"); 
		
	ИначеЕсли ВидыДокументов = "УведомленияОбОтгрузке" Тогда
		Элементы.ДекорацияПояснение.Заголовок = нСтр("ru='Получение документов Уведомления об отгрузке товаров (ЕАЭС)'", "ru"); 
		
	Иначе
		Элементы.ДекорацияПояснение.Заголовок = нСтр("ru='Получение документов ИС МПТ'", "ru"); 	
	КонецЕсли;
		
КонецПроцедуры	

&НаКлиенте
Функция ПолучитьТокенАвторизации(Организация = Неопределено) Экспорт
	
	Возврат ИнтеграцияИСМПТККлиент.ПолучитьТокенАвторизации(Организация, ПолучитьТипДокумента(), Ложь);
	
КонецФункции

&НаКлиенте
Функция СоздатьЭЦП_CMS_NCA_Layer(Знач ДанныеXML, ТипВходящихДанных, Знач ВключатьДанныеВПодпись) Экспорт
	
	Возврат ИнтеграцияИСМПТККлиент.СоздатьЭЦП_CMS_NCA_Layer(ДанныеXML, ТипВходящихДанных, ВключатьДанныеВПодпись);

КонецФункции

&НаКлиенте
Функция ПолучитьТипДокумента()
	Если ВидыДокументов = "Акты" Тогда
		Возврат "АктПриемаПередачиИСМПТК";
	ИначеЕсли ВидыДокументов = "УведомленияОВвозе" Тогда
		Возврат "УведомлениеОВвозеИзЕАЭСИСМПТК";
	ИначеЕсли ВидыДокументов = "УведомленияОВвозеИмпорт" Тогда
		Возврат "УведомлениеОВвозеИзТретьихСтранИСМПТК";
	ИначеЕсли ВидыДокументов = "УведомленияОбОтгрузке" Тогда
		Возврат "УведомлениеОбОтгрузкеЕАЭСИСМПТК";
	Иначе
		Возврат "";
	КонецЕсли;
КонецФункции