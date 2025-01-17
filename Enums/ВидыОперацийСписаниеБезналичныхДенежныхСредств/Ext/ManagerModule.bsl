﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

Процедура ОбработкаПолученияДанныхВыбора(ДанныеВыбора, Параметры, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	СписокИсключений = Новый Массив;
	
	Если Не ПолучитьФункциональнуюОпцию("ВедетсяУчетЗарплатыИКадры") Тогда
		СписокИсключений.Добавить(Перечисления.ВидыОперацийСписаниеБезналичныхДенежныхСредств.ПеречислениеЗаработнойПлаты);
	КонецЕсли;
	
	ДанныеВыбора = Новый СписокЗначений;
	
	Для Каждого ЗначениеПеречисления Из Перечисления.ВидыОперацийСписаниеБезналичныхДенежныхСредств Цикл
		Если СписокИсключений.Найти(ЗначениеПеречисления) = Неопределено Тогда
			ДанныеВыбора.Добавить(ЗначениеПеречисления);
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

#КонецЕсли