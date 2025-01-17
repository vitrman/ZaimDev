﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

Процедура ПередЗаписью(Отказ, Замещение)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат
	КонецЕсли;
	
	Для Каждого СтрокаНабора Из ЭтотОбъект Цикл
		
		Если СтрокаНабора.Период < Дата('20230101') Тогда
			
			ВызватьИсключение НСтр("ru = 'Сведения о ставках для налогового режима ""Розничный налог"" указываются с 01.01.2023 года.'");
			
		КонецЕсли;
		
		Если СтрокаНабора.Ставка.Ставка = 0 И НЕ ЗначениеЗаполнено(СтрокаНабора.ВидДохода) Тогда
			
			ВызватьИсключение НСтр("ru = 'Для записи со ставкой 0% ""Вид дохода"" должен быть заполнен.'");
			
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)
	
	ОрганизацияПоУмолчанию = Справочники.Организации.ОрганизацияПоУмолчанию();
	Если ЗначениеЗаполнено(ОрганизацияПоУмолчанию) Тогда 
		Для Каждого Запись Из ЭтотОбъект Цикл
			Если НЕ ЗначениеЗаполнено(Запись.Организация) Тогда 
				Запись.Организация = ОрганизацияПоУмолчанию;
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры

#КонецЕсли
