﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

Процедура ОбработкаПолученияПредставления(Данные, Представление, СтандартнаяОбработка)
	
	Представление = "Уведомление об экспорте (ЕАЭС) № " + Данные.Номер + " от " + Формат(Данные.Дата, "ДФ = dd.MM.yyyy HH:mm:ss") + "";
	СтандартнаяОбработка = Ложь;
	
КонецПроцедуры

Процедура ОбработкаПолученияПолейПредставления(Поля, СтандартнаяОбработка)
	
	Поля.Добавить("Номер");
	Поля.Добавить("Дата");
	СтандартнаяОбработка = Ложь;
	
КонецПроцедуры

#Область СтандартныеПодсистемы

Процедура ПриОпределенииНастроекВерсионированияОбъектов(Настройки) Экспорт
	
КонецПроцедуры

Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт
	
	ИнтеграцияИСМПТКПереопределяемый.ПриЗаполненииОграниченияДоступа(Ограничение, "УведомлениеОбЭкспортеЕАЭСИСМПТК");
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли