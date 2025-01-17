﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПриЗаписи(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	УстановитьПривилегированныйРежим(Истина);
	
	ВестиУчетМаркируемойПродукции = Значение ИЛИ Константы.ВестиУчетМаркируемойОбувиИСМПТК.Получить();
	
	Константы.ВестиУчетМаркируемойПродукцииИСМПТК.Установить(ВестиУчетМаркируемойПродукции);
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли
