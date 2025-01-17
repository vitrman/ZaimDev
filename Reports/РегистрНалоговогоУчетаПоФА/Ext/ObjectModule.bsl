﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

////////////////////////////////////////////////////////////////////////////////
// ПЕРЕМЕННЫЕ МОДУЛЯ

////////////////////////////////////////////////////////////////////////////////
// ПРОГРАММНЫЙ ИНТЕРФЕЙС

Процедура ОпределитьНастройкиФормы(Форма, КлючВарианта, Настройки) Экспорт
	
	Настройки.События.ПриСозданииНаСервере = Истина;
	Настройки.События.ПередЗагрузкойНастроекВКомпоновщик   = Истина;
	Настройки.События.ПередЗагрузкойВариантаНаСервере      = Истина;
	Настройки.События.ПослеЗаполненияПанелиБыстрыхНастроек = Истина;
	
	Если Форма <> Неопределено Тогда
		ИмяИсходногоВарианта = Настройки.ИмяИсходногоВарианта;
		Если ИмяИсходногоВарианта = "АмортизацияФАиДр" Тогда
			Настройки.КлючСхемы = "АмортизацияФАиДр";
		ИначеЕсли ИмяИсходногоВарианта = "РасшифровкаАмортизационныхОтчислений" Тогда
			Настройки.КлючСхемы = "РасшифровкаАмортизационныхОтчислений";
		ИначеЕсли ИмяИсходногоВарианта = "ДвойнаяНормаАмортизацииФА" Тогда
			Настройки.КлючСхемы = "ДвойнаяНормаАмортизацииФА";
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры 

Процедура ПриСозданииНаСервере(Форма, Отказ, СтандартнаяОбработка) Экспорт

	Элементы = Форма.Элементы;
	
	Элементы.ГруппаПериод.Видимость = Истина;
	Форма.ЕстьНачалоПериодаБК       = Истина;
	Форма.ЕстьКонецПериодаБК        = Истина;
	
	Элементы.Период.Видимость = Ложь;
	Форма.ЕстьПериодБК        = Ложь;
	
	Элементы.ГруппаДополнительные.Видимость = Ложь;
	
	Форма.ВидРегистраОтчета = "АмортизацияФАиДр";
	
	Форма.ПеречислениеРазделыНалоговогоУчета        = Перечисления.РазделыНалоговогоУчета.КПН;
	Форма.РежимВыбораСтруктурныхЕдиниц              = "";
	Элементы.ГруппаОрганизацияРегистрНУ.Видимость   = Истина;
	Элементы.ГруппаОрганизация.Видимость            = Ложь;
	
	Элементы.ВыводитьЗаголовок.Видимость            = Истина;
	Элементы.ВыводитьПодписи.Видимость              = Истина;
	Элементы.ВыводитьПодписиРуководителей.Видимость = Ложь;
	
	Если НЕ Форма.РежимРасшифровки Тогда
		Форма.НачалоПериода = НачалоМесяца(ОбщегоНазначения.ТекущаяДатаПользователя());
		Форма.КонецПериода  = КонецМесяца(ОбщегоНазначения.ТекущаяДатаПользователя());
	КонецЕсли;	
	
КонецПроцедуры

Процедура ПередЗагрузкойНастроекВКомпоновщик(Контекст, КлючСхемы, КлючВарианта, НовыеНастройкиКД, НовыеПользовательскиеНастройкиКД) Экспорт
	
	Если НЕ ТипЗнч(Контекст) = Тип("ФормаКлиентскогоПриложения") Тогда
		Возврат;
	КонецЕсли;

	ИмяИсходногоВарианта = Контекст.НастройкиОтчета.ИмяИсходногоВарианта;
	
	Если ИмяИсходногоВарианта <> "АмортизацияФАиДр"
		И ИмяИсходногоВарианта <> "РасшифровкаАмортизационныхОтчислений"
		И ИмяИсходногоВарианта <> "ДвойнаяНормаАмортизацииФА" Тогда
		
		ИмяИсходногоВарианта = НайтиВариантПоКлючу(ИмяИсходногоВарианта);
	КонецЕсли;
	
	Если ИмяИсходногоВарианта <> "АмортизацияФАиДр"
		И ИмяИсходногоВарианта <> "РасшифровкаАмортизационныхОтчислений"
		И ИмяИсходногоВарианта <> "ДвойнаяНормаАмортизацииФА"
		И НовыеПользовательскиеНастройкиКД <> Неопределено
		И НовыеПользовательскиеНастройкиКД.ДополнительныеСвойства.Свойство("ВидРегистраОтчета") Тогда
		
		ИмяИсходногоВарианта = НовыеПользовательскиеНастройкиКД.ДополнительныеСвойства.ВидРегистраОтчета;
	КонецЕсли;
	
	Если ИмяИсходногоВарианта <> "АмортизацияФАиДр"
		И ИмяИсходногоВарианта <> "РасшифровкаАмортизационныхОтчислений"
		И ИмяИсходногоВарианта <> "ДвойнаяНормаАмортизацииФА"
		И НовыеНастройкиКД <> Неопределено
		И НовыеНастройкиКД.ДополнительныеСвойства.Свойство("ВидРегистраОтчета") Тогда
		
		ИмяИсходногоВарианта = НовыеНастройкиКД.ДополнительныеСвойства.ВидРегистраОтчета;
	КонецЕсли;
	
	Если ИмяИсходногоВарианта = "АмортизацияФАиДр"
		ИЛИ ИмяИсходногоВарианта = "РасшифровкаАмортизационныхОтчислений"
		ИЛИ ИмяИсходногоВарианта = "ДвойнаяНормаАмортизацииФА" Тогда

		СхемаКомпоновкиДанных = ПолучитьМакет(ИмяИсходногоВарианта);
		ОтчетыСервер.ПодключитьСхему(ЭтотОбъект, Контекст, СхемаКомпоновкиДанных, ИмяИсходногоВарианта);
		Если Контекст.ИмяФормы = "ОбщаяФорма.ФормаОтчетаБК" Тогда
			Контекст.ВидРегистраОтчета = ИмяИсходногоВарианта;
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

Процедура ПередЗагрузкойВариантаНаСервере(Форма, Настройки) Экспорт
	
	Схема = ПолучитьИзВременногоХранилища(Форма.НастройкиОтчета.АдресСхемы);
	
	ПредопределенныйВариантОтчета = Схема.ВариантыНастроек.Найти(Форма.КлючТекущегоВарианта);
	
	ЭтоПредопределенныйВариант = Схема.ВариантыНастроек.Найти(Форма.КлючТекущегоВарианта) <> Неопределено;
	
	Если ЭтоПредопределенныйВариант Тогда
		КлючТекущегоВарианта = Форма.КлючТекущегоВарианта;
	Иначе
		КлючТекущегоВарианта = НайтиВариантПоКлючу(Форма.КлючТекущегоВарианта); 
	КонецЕсли;
	
	Если (КлючТекущегоВарианта = "АмортизацияФАиДр"
		ИЛИ КлючТекущегоВарианта = "РасшифровкаАмортизационныхОтчислений"
		ИЛИ КлючТекущегоВарианта = "ДвойнаяНормаАмортизацииФА")
		И Настройки.ДополнительныеСвойства.Свойство("ВидРегистраОтчета") Тогда
		
		КлючТекущегоВарианта = Настройки.ДополнительныеСвойства.ВидРегистраОтчета;
	КонецЕсли;
	
	Если КлючТекущегоВарианта = "АмортизацияФАиДр"
		ИЛИ КлючТекущегоВарианта = "РасшифровкаАмортизационныхОтчислений"
		ИЛИ КлючТекущегоВарианта = "ДвойнаяНормаАмортизацииФА" Тогда
		
		СхемаКомпоновкиДанных = ПолучитьМакет(КлючТекущегоВарианта);
		НастройкиВарианта = СхемаКомпоновкиДанных.ВариантыНастроек[КлючТекущегоВарианта].Настройки;
		Если Настройки.ДополнительныеСвойства.Количество() > 0 Тогда
			КомпоновщикНастроек.ЗагрузитьНастройки(Настройки);
		Иначе
			КомпоновщикНастроек.ЗагрузитьНастройки(НастройкиВарианта);
		КонецЕсли;
		Настройки = КомпоновщикНастроек.ПолучитьНастройки();
	КонецЕсли;
   
КонецПроцедуры

Процедура ПослеЗаполненияПанелиБыстрыхНастроек(Форма, ПараметрыЗаполнения) Экспорт
	
	Если ПараметрыЗаполнения.ИмяСобытия = "НастройкиПоУмолчанию" Тогда
		Форма.ПользовательскиеНастройкиМодифицированы = Ложь;
	КонецЕсли;
	
КонецПроцедуры


////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	ДополнительныеСвойства = КомпоновщикНастроек.ПользовательскиеНастройки.ДополнительныеСвойства;
	Если ДополнительныеСвойства.Свойство("НастройкиОтчета") И ТипЗнч(ДополнительныеСвойства.НастройкиОтчета) = Тип("Структура") Тогда
		НастройкиОтчета  = ДополнительныеСвойства.НастройкиОтчета;
		НачалоПериода    = НастройкиОтчета.НачалоПериода;
		КонецПериода     = НастройкиОтчета.КонецПериода;
		Налогоплательщик = НастройкиОтчета.Налогоплательщик;
	КонецЕсли;
	
	БухгалтерскиеОтчетыВызовСервера.ОбработкаПроверкиЗаполнения(ЭтотОбъект, Отказ, Новый Структура("КорректностьПериода", Истина));
	
КонецПроцедуры

Процедура ПриКомпоновкеРезультата(ДокументРезультат, ДанныеРасшифровки, СтандартнаяОбработка)
	
	ПользовательскиеНастройки = КомпоновщикНастроек.ПользовательскиеНастройки;
	
	ХранилищеСвойств = БухгалтерскиеОтчетыКлиентСервер.ПолучитьПараметр(КомпоновщикНастроек, "НастройкиОтчета");
	Если ХранилищеСвойств <> Неопределено И ТипЗнч(ХранилищеСвойств.Значение) = Тип("ХранилищеЗначения") Тогда
		НастройкиОтчета = ХранилищеСвойств.Значение.Получить();
	Иначе
		Возврат;
	КонецЕсли;
	
	Если НастройкиОтчета.ВыводитьЗаголовок Тогда
		Отчеты.РегистрНалоговогоУчетаПоФА.ПриВыводеЗаголовка(НастройкиОтчета, ДокументРезультат);
	КонецЕсли;
	
	СписокСубконтоСчетаРемонта =  Новый СписокЗначений();
	СписокСубконтоСчетаРемонта.Добавить(ПланыВидовХарактеристик.ВидыСубконтоТиповые.ВнеоборотныеАктивы);
	СписокСубконтоСчетаРемонта.Добавить(ПланыВидовХарактеристик.ВидыСубконтоТиповые.ВидыРемонтаВА);
	СписокСубконтоСчетаРемонта.Добавить(ПланыВидовХарактеристик.ВидыСубконтоТиповые.СтатьиЗатрат);
	
	БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "СписокСубконтоСчетаРемонта", СписокСубконтоСчетаРемонта);
	БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "СчетРемонтаВА", ПланыСчетов.Налоговый.РасходыНаРемонтВА);
	БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "СчетУчетаВА", ПланыСчетов.Налоговый.ВАВключенныеВСтоимостнойБаланс);
	
	Если ЗначениеЗаполнено(НастройкиОтчета.НачалоПериода) Тогда
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "НачалоПериода", НачалоДня(НастройкиОтчета.НачалоПериода));
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ДатаНачала"   , НачалоДня(НастройкиОтчета.НачалоПериода));
	Иначе
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "НачалоПериода", Дата(1, 1, 1));
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ДатаНачала"   , Дата(1, 1, 1));
	КонецЕсли;
	Если ЗначениеЗаполнено(НастройкиОтчета.КонецПериода) Тогда
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "КонецПериода" , КонецДня(НастройкиОтчета.КонецПериода));
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ДатаОкончания", КонецДня(НастройкиОтчета.КонецПериода));
	Иначе
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "КонецПериода" , Дата(3999, 11, 1));
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ДатаОкончания", Дата(3999, 11, 1));
	КонецЕсли;
	
	СостоянияФА = Новый СписокЗначений();	
	СостоянияФА.Добавить(Перечисления.ВидыСостоянийФА.ПринятКУчету);
	СостоянияФА.Добавить(Перечисления.ВидыСостоянийФА.Выбыл);
	
	БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ПустаяГруппаНУ"     , Справочники.ГруппыНалоговогоУчетаФА.ПустаяСсылка());	
	БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ПустаяОрганизация"  , Справочники.Организации.ПустаяСсылка());	
	БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "СписокОрганизаций"  , НастройкиОтчета.СписокСтруктурныхЕдиниц);
	
	БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "СостоянияФА"        , СостоянияФА);
	БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "УчетПоОбъектам"     , Перечисления.ВидыНалоговогоУчетаВГруппахФА.ПоОбъектам);
	БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ВидУчетаНУ"         , Справочники.ВидыУчетаНУ.НУ);
	
	БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ДвижениеПоступления", Перечисления.ВидыДвиженияСтоимостиФА.Поступление);
	БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ДвижениеВыбытия"    , Перечисления.ВидыДвиженияСтоимостиФА.Выбытие);
	БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ДвижениеАмортизации", Перечисления.ВидыДвиженияСтоимостиФА.Амортизация);
	
	Если НастройкиОтчета.ВидРегистраОтчета = "АмортизацияФАиДр" Тогда 
		
		МассивСубконтоЗатратНаРемонт = Новый СписокЗначений();
		МассивСубконтоЗатратНаРемонт.Добавить(ПланыВидовХарактеристик.ВидыСубконтоТиповые.ВнеоборотныеАктивы);
		МассивСубконтоЗатратНаРемонт.Добавить(ПланыВидовХарактеристик.ВидыСубконтоТиповые.ВидыРемонтаВА);
		МассивСубконтоЗатратНаРемонт.Добавить(ПланыВидовХарактеристик.ВидыСубконтоТиповые.СтатьиЗатрат);
		
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ВидЛьготыФА"  , Перечисления.ВидыФАУчитываемыхОтдельно.ОбъектыПреференций);
	
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "СчетУчетаВА"               , ПланыСчетов.Налоговый.ВАВключенныеВСтоимостнойБаланс);		//Счет Н311
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "СчетРемонтаВА"             , ПланыСчетов.Налоговый.РасходыНаРемонтВА);	    //Счет Н860
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ВидРемонтаВА_Капитальный"  , Перечисления.ВидыРемонтаВА.Капитальный);
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ВидРемонтаВА_Текущий"      , Перечисления.ВидыРемонтаВА.Текущий);
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "СписокСубконтоСчетаРемонта", МассивСубконтоЗатратНаРемонт);
	
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "УчитываетсяОтдельноОтСтоимостногоБаланса", Перечисления.СобытияФАУчитываемыхОтдельно.ПринятиеКУчету);	
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ДвижениеСписаниеБалансаМенееМинимума"    , Перечисления.ВидыДвиженияСтоимостиФА.СписаниеСтоимостногоБалансаГруппыМенееМинимума);
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ДвижениеСписаниеБалансаВыбывших"         , Перечисления.ВидыДвиженияСтоимостиФА.СписаниеПриВыбытииВсехАктивовГруппы);
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ДвижениеУвеличениеСтоимостиЗаСчетРемонта", Перечисления.ВидыДвиженияСтоимостиФА.УвеличениеСтоимостиЗаСчетРемонта);
	
	ИначеЕсли НастройкиОтчета.ВидРегистраОтчета = "РасшифровкаАмортизационныхОтчислений" Тогда 
		
		МассивСубконтоЗатратНаРемонт = Новый СписокЗначений();
		МассивСубконтоЗатратНаРемонт.Добавить(ПланыВидовХарактеристик.ВидыСубконтоТиповые.ВнеоборотныеАктивы);
		МассивСубконтоЗатратНаРемонт.Добавить(ПланыВидовХарактеристик.ВидыСубконтоТиповые.ВидыРемонтаВА);
		МассивСубконтоЗатратНаРемонт.Добавить(ПланыВидовХарактеристик.ВидыСубконтоТиповые.СтатьиЗатрат);
		
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ВидЛьготыФА", Перечисления.ВидыФАУчитываемыхОтдельно.ОбъектыПреференций);
	
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "СчетУчетаВА"               , ПланыСчетов.Налоговый.ВАВключенныеВСтоимостнойБаланс);		//Счет Н311
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "СчетРемонтаВА"             , ПланыСчетов.Налоговый.РасходыНаРемонтВА);	    //Счет Н860
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ВидРемонтаВА_Капитальный"  , Перечисления.ВидыРемонтаВА.Капитальный);
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ВидРемонтаВА_Текущий"      , Перечисления.ВидыРемонтаВА.Текущий);
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "СписокСубконтоСчетаРемонта", МассивСубконтоЗатратНаРемонт);
	
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "УчитываетсяОтдельноОтСтоимостногоБаланса", Перечисления.СобытияФАУчитываемыхОтдельно.ПринятиеКУчету);	
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ДвижениеСписаниеБалансаМенееМинимума"    , Перечисления.ВидыДвиженияСтоимостиФА.СписаниеСтоимостногоБалансаГруппыМенееМинимума);
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ДвижениеСписаниеБалансаВыбывших"         , Перечисления.ВидыДвиженияСтоимостиФА.СписаниеПриВыбытииВсехАктивовГруппы);
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ДвижениеУвеличениеСтоимостиЗаСчетРемонта", Перечисления.ВидыДвиженияСтоимостиФА.УвеличениеСтоимостиЗаСчетРемонта);

	ИначеЕсли НастройкиОтчета.ВидРегистраОтчета = "ДвойнаяНормаАмортизацииФА" Тогда 
		
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "Период"                 , КонецДня(НастройкиОтчета.КонецПериода));
		
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ДатаОкончания1ГодНазад" , ДобавитьМесяц(КонецДня(НастройкиОтчета.КонецПериода), -12));
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ДатаОкончания2ГодаНазад", ДобавитьМесяц(КонецДня(НастройкиОтчета.КонецПериода), -24));
		
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "СчетУчетаВА"            , ПланыСчетов.Налоговый.ВнеоборотныеАктивы);		//Счет Н300
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ВключенВСоставГруппы"   , Перечисления.СобытияФАУчитываемыхОтдельно.ВключениеВСоставГруппы);	    
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "Выбыл"                  , Перечисления.ВидыСостоянийФА.Выбыл);
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ПринятКУчету"           , Перечисления.ВидыСостоянийФА.ПринятКУчету);
		
	КонецЕсли;
	
	ИзмененыНастройкиВариант = Истина;
	Если ПользовательскиеНастройки.ДополнительныеСвойства.Свойство("КлючВарианта") Тогда
		Если ПользовательскиеНастройки.ДополнительныеСвойства.КлючВарианта <> "АмортизацияФАиДр"
			И ПользовательскиеНастройки.ДополнительныеСвойства.КлючВарианта <> "РасшифровкаАмортизационныхОтчислений"
			И ПользовательскиеНастройки.ДополнительныеСвойства.КлючВарианта <> "ДвойнаяНормаАмортизацииФА" Тогда
			ИзмененыНастройкиВариант = Истина;
		Иначе
			Если НастройкиОтчета.Свойство("ИзмененыНастройкиВариант") Тогда
				ИзмененыНастройкиВариант = НастройкиОтчета.ИзмененыНастройкиВариант;
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
	
	СтруктураОтчета = КомпоновщикНастроек.Настройки.Структура;
	Если СтруктураОтчета.Количество() > 0 И ИзмененыНастройкиВариант Тогда
		Для Каждого ЭлементСтруктуры Из СтруктураОтчета Цикл
			ОтчетыВызовСервераБК.ОчиститьИменаСтруктуры(ЭлементСтруктуры);
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры


////////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ

Функция НайтиВариантПоКлючу(КлючВарианта)
	
	Запрос = Новый Запрос;
	
	Запрос.УстановитьПараметр("КлючВарианта", КлючВарианта);
	
	Запрос.Текст = "ВЫБРАТЬ
	               |	ВариантыОтчетов.Ссылка
	               |ИЗ
	               |	Справочник.ВариантыОтчетов КАК ВариантыОтчетов
	               |ГДЕ
	               |	ВариантыОтчетов.КлючВарианта = &КлючВарианта";
	
	Вариант = Запрос.Выполнить().Выбрать();

	Если Вариант.Следующий() Тогда
		
		ВариантОтчета = Вариант.Ссылка;
		Если ЗначениеЗаполнено(ВариантОтчета.ПредопределенныйВариант) Тогда
			Возврат ВариантОтчета.ПредопределенныйВариант.КлючВарианта;
		Иначе	
			ДополнительныеСвойства = ВариантОтчета.Настройки.Получить().ДополнительныеСвойства;
			Если ДополнительныеСвойства.Свойство("КлючВарианта") Тогда
				Возврат ВариантОтчета.Настройки.Получить().ДополнительныеСвойства.КлючВарианта;
			КонецЕсли;
		КонецЕсли;

	КонецЕсли;
	
	Возврат "";
	
КонецФункции 

Процедура ВывестиПодписи(ДокументРезультат) Экспорт
	
	ДополнительныеСвойства = КомпоновщикНастроек.ПользовательскиеНастройки.ДополнительныеСвойства;
	Если ДополнительныеСвойства.Свойство("НастройкиОтчета") И ТипЗнч(ДополнительныеСвойства.НастройкиОтчета) = Тип("Структура") Тогда
		НастройкиОтчета = ДополнительныеСвойства.НастройкиОтчета;
	Иначе
		Возврат;
	КонецЕсли;
	
	Если НастройкиОтчета.ВыводитьПодписи Тогда
		Отчеты.РегистрНалоговогоУчетаПоФА.ПриВыводеПодвала(НастройкиОтчета, ДокументРезультат);
	КонецЕсли;
	
КонецПроцедуры


////////////////////////////////////////////////////////////////////////////////
// ОПЕРАТОРЫ ОСНОВНОЙ ПРОГРАММЫ

#КонецЕсли
