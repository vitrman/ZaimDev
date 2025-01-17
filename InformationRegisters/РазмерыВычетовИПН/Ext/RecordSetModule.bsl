﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ, Замещение)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Для Каждого СтрокаНабора Из ЭтотОбъект Цикл
		
		Если СтрокаНабора.Период < Дата('20190101') Тогда
			
			ВызватьИсключение НСтр("ru = 'Данные в регистр сведений о размере предела вычета ИПН вводятся не ранее 2019 года (до 2019 используется реквизит справочника ""Виды вычетов ИПН"")'");	
			
		КонецЕсли;
		
		Если СтрокаНабора.ВидВычетаИПН.ПредоставлениеВычета = Перечисления.ВидыПредоставленияВычетов.ПоИсчисленнойСуммеВзносов Тогда
			
			ВызватьИсключение НСтр("ru = 'Невозможно ввести данные о размере вычета для периода предоставления ""По исчисленной сумме взносов""'");	
			
		КонецЕсли;
		
		Если СтрокаНабора.ВидВычетаИПН = Справочники.ВычетыИПН.ВычетОПВ
			ИЛИ СтрокаНабора.ВидВычетаИПН = Справочники.ВычетыИПН.ДобровольныеПенсионныеВзносы
			ИЛИ СтрокаНабора.ВидВычетаИПН = Справочники.ВычетыИПН.ПогашениеВознагражденияПоЖилищнымЗаймам Тогда
			
			ВызватьИсключение СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru = 'Невозможно ввести данные о размере для вычетов ""%1"", ""%2"", ""%3""'"), 
																						Справочники.ВычетыИПН.ВычетОПВ, 
																						Справочники.ВычетыИПН.ДобровольныеПенсионныеВзносы, 
																						Справочники.ВычетыИПН.ПогашениеВознагражденияПоЖилищнымЗаймам);
			
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

Процедура ПриЗаписи(Отказ, Замещение)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	ОбновитьПовторноИспользуемыеЗначения();
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли
