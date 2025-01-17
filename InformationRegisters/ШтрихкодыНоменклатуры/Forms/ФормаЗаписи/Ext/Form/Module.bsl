﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Элементы.Номенклатура.ТолькоПросмотр = Параметры.ЗначенияЗаполнения.Свойство("Номенклатура");
	
	Если ПравоДоступа("Чтение", Метаданные.Справочники.ПодключаемоеОборудование) Тогда
		ИспользуютсяСканерыШтрихкода = (МенеджерОборудованияВызовСервера.ОборудованиеПоПараметрам("СканерШтрихкода").Количество() > 0);
	Иначе
		ИспользуютсяСканерыШтрихкода = Ложь;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	Если ИспользуютсяСканерыШтрихкода И НЕ ТолькоПросмотр Тогда
		// Попробуем подключить сканер штрихкода
		ОповещенияПриПодключении = Новый ОписаниеОповещения("ПодключитьСканерШКЗавершение", ЭтотОбъект); 
		МенеджерОборудованияКлиент.НачатьПодключениеОборудованиеПоТипу(ОповещенияПриПодключении, УникальныйИдентификатор, "СканерШтрихкода");
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	Если Источник = "ПодключаемоеОборудование" И ВводДоступен() Тогда
		Если ИмяСобытия = "ScanData" Тогда
			Если Параметр[1] = Неопределено Тогда
				Запись.Штрихкод = Параметр[0];
			Иначе
				Запись.Штрихкод = Параметр[1][1];
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии(ЗавершениеРаботы)
	// ПодключаемоеОборудование
	Если СканерШтрихкодаПодключен И НЕ ЗавершениеРаботы Тогда
		ТипыПО = ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве("СканерШтрихкода");
		ОповещенияПриОтключении = Новый ОписаниеОповещения("ОтключитьСканерШКЗавершение", ЭтотОбъект); 
		МенеджерОборудованияКлиент.НачатьОтключениеОборудованиеПоТипу(ОповещенияПриОтключении, УникальныйИдентификатор, ТипыПО);
	КонецЕсли;
	//Конец  ПодключаемоеОборудование
КонецПроцедуры

#КонецОбласти 


#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ПодключитьСканерШКЗавершение(РезультатВыполнения, ДополнительныеПараметры) Экспорт

	СканерШтрихкодаПодключен = РезультатВыполнения.Результат;

КонецПроцедуры

&НаКлиенте
Процедура ОтключитьСканерШКЗавершение(РезультатВыполнения, ДополнительныеПараметры) Экспорт

	Если Не РезультатВыполнения.Результат Тогда
		ТекстСообщения = НСтр("ru = 'При отключении оборудования произошла ошибка: ""%1"".'");
		ТекстСообщения = СтрШаблон(ТекстСообщения, РезультатВыполнения.ОписаниеОшибки);
		ОбщегоНазначенияКлиент.СообщитьПользователю(ТекстСообщения);
	Иначе
		СканерШтрихкодаПодключен = Ложь;
	КонецЕсли;

КонецПроцедуры

#КонецОбласти 



