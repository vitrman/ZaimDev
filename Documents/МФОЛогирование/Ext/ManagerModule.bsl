﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

Процедура ЗаписатьДокументЛог(Событие="",Описание="", УровеньЛогирования = 0, ДокументМФОЗайм = Неопределено, СсылкаДокументЛог = Неопределено) Экспорт
	
	ТекущийУровеньЛогирования = Константы.МФОУровеньЛогирования.Получить();
	Если ТекущийУровеньЛогирования < УровеньЛогирования тогда
		Возврат;
	КонецЕсли;
	
	Если ЗначениеЗаполнено(СсылкаДокументЛог) и ТипЗнч(СсылкаДокументЛог) = Тип("ДокументСсылка.МФОЛогирование") тогда
		ДокументЛог = СсылкаДокументЛог.ПолучитьОбъект();
	иначе
		ДокументЛог = СоздатьДокумент();
	ДокументЛог.Дата = ТекущаяДата();
	ДокументЛог.Событие = Событие;
	КонецЕсли;
	
	Если ДокументМФОЗайм <> Неопределено и ТипЗнч(ДокументМФОЗайм) = Тип("ДокументСсылка.МФОЗайм") тогда
		ДокументЛог.ДокументМФОЗайм = ДокументМФОЗайм;
	КонецЕсли;
	
	Если ТипЗнч(Описание) = Тип("Массив") тогда
		ОписаниеСтроки = ДокументЛог.Описание;
		Для Каждого СтрокаМассив из Описание Цикл
			ОписаниеСтроки= ОписаниеСтроки + СтрокаМассив + Символы.ПС;
		КонецЦикла;		
		ДокументЛог.Описание = ОписаниеСтроки;
	иначе
		ДокументЛог.Описание =ДокументЛог.Описание + Описание;
	КонецЕсли;
	ДокументЛог.Записать();
КонецПроцедуры

Функция ПолучитьНовыйДокументЛог(Событие="", УровеньЛогирования = 0) Экспорт
	
	ТекущийУровеньЛогирования = Константы.МФОУровеньЛогирования.Получить();
	Если ТекущийУровеньЛогирования < УровеньЛогирования тогда
		Возврат Документы.МФОЛогирование.ПустаяСсылка();
	КонецЕсли;
	
	Попытка
		ДокументЛог = СоздатьДокумент();
		ДокументЛог.Дата = ТекущаяДата();
		ДокументЛог.Событие = Событие; 
		 ДокументЛог.УстановитьНовыйНомер();
		ДокументЛог.Записать();
	Исключение                                        
		ЗаписатьДокументЛог("Ошибка создания документа Логирования", ОписаниеОшибки(),2);
		Возврат Документы.МФОЛогирование.ПустаяСсылка();
	КонецПопытки;
	Возврат ДокументЛог.Ссылка;
	
КонецФункции // ПолучитьНовыйДокументЛог()

#КонецОбласти

#Область ОбработчикиСобытий

// Код процедур и функций

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Код процедур и функций

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Код процедур и функций

#КонецОбласти

#КонецЕсли
