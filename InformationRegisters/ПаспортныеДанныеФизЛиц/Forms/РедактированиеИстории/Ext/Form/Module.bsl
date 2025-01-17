﻿
////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ФОРМЫ

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	Параметры.Свойство("ВедущийОбъект", ОбъектВладелец);
	Если Не ЗначениеЗаполнено(ОбъектВладелец) Тогда
		Отказ = Истина;
		Возврат;
	КонецЕсли;

	Если ТолькоПросмотр Тогда
		Элементы.НаборЗаписей.ТолькоПросмотр = Истина;
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Элементы, 
			"ФормаКомандаОК",
			"Доступность",
			Ложь);
		Элементы.ФормаКомандаОтмена.КнопкаПоУмолчанию = Истина;
	Иначе
		Элементы.ГруппаИнформационная.Видимость = Ложь;
	КонецЕсли;

	Для Каждого ЗаписьНабора Из Параметры.МассивЗаписей Цикл
		ЗаполнитьЗначенияСвойств(НаборЗаписей.Добавить(), ЗаписьНабора);
	КонецЦикла;
	
	НаборЗаписей.Сортировать("Период");
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ТАБЛИЦЫ ФОРМЫ НаборЗаписей

&НаКлиенте
Процедура НаборЗаписейПриНачалеРедактирования(Элемент, НоваяСтрока, Копирование)
	
	Если НоваяСтрока Тогда
		Если Элемент.ТекущиеДанные <> Неопределено Тогда
			Элемент.ТекущиеДанные.ФизЛицо = ОбъектВладелец;
			Если НаборЗаписей.Количество() > 1 Тогда
				НовыйПериод = Макс(КонецДня(НаборЗаписей.Получить(НаборЗаписей.Количество() - 2).Период) + 1, НачалоДня(ОбщегоНазначенияКлиент.ДатаСеанса()));
			Иначе
				НовыйПериод = Дата(1900, 1, 1);
			КонецЕсли; 
			Элемент.ТекущиеДанные.Период = НовыйПериод;
		КонецЕсли;
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура НаборЗаписейПередОкончаниемРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования, Отказ)
	
	Если НЕ ОтменаРедактирования Тогда
		Если Элемент.ТекущиеДанные <> Неопределено Тогда
			Если НЕ ЗначениеЗаполнено(Элемент.ТекущиеДанные.Период) Тогда
				СообщениеОбОшибке = НСтр("ru = 'Необходимо указать период, с которого будет действовать запись сведений'");
				ОбщегоНазначенияКлиент.СообщитьПользователю(СообщениеОбОшибке,,"НаборЗаписей.Период", , Отказ);
			Иначе
				НайденныеСтроки = НаборЗаписей.НайтиСтроки(Новый Структура("Период", Элемент.ТекущиеДанные.Период));
				Для Каждого НайденнаяСтрока Из НайденныеСтроки Цикл
					Если НайденнаяСтрока <> Элемент.ТекущиеДанные Тогда
						СообщениеОбОшибке = НСтр("ru = 'Уже есть запись с указанным периодом сведений'");
						ОбщегоНазначенияКлиент.СообщитьПользователю(СообщениеОбОшибке,,"НаборЗаписей.Период", , Отказ);
						Прервать;
					КонецЕсли; 
				КонецЦикла;
			КонецЕсли; 
		КонецЕсли;
	Иначе
		Если НЕ НоваяСтрока И НЕ ЗначениеЗаполнено(Элемент.ТекущиеДанные.Период) Тогда
			СообщениеОбОшибке = НСтр("ru = 'Необходимо указать период, с которого будет действовать запись сведений'");
			ОбщегоНазначенияКлиент.СообщитьПользователю(СообщениеОбОшибке,,"НаборЗаписей.Период", , Отказ);
		КонецЕсли;
	КонецЕсли; 

КонецПроцедуры

&НаКлиенте
Процедура НаборЗаписейПриОкончанииРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования)
	
	РедактированиеПериодическихСведенийКлиент.УпорядочитьНаборЗаписейВФорме(ЭтаФорма);
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ КОМАНД ФОРМЫ

&НаКлиенте
Процедура КомандаОК(Команда)

	РедактированиеПериодическихСведенийКлиент.ОповеститьОЗавершении(ЭтаФорма, "ПаспортныеДанныеФизЛиц", ОбъектВладелец);
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаОтмена(Команда)
	Закрыть();
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ
