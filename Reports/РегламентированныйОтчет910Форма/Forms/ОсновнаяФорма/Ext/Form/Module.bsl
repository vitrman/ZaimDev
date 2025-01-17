﻿
////////////////////////////////////////////////////////////////////////////////
// ПРОЦЕДУРЫ И ФУНКЦИИ ОБЩЕГО НАЗНАЧЕНИЯ

// Процедура управляет показом в форме периода построения отчета.
//
&НаКлиентеНаСервереБезКонтекста
Процедура ПоказатьПериод(Форма)

	Если  (Форма.мДатаКонцаПериодаОтчета < Форма.мДатаНачалаПериодаОтчета) Тогда
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru='Неверно задан период'"));
		Возврат;
	КонецЕсли;

	Если Форма.мДатаНачалаПериодаОтчета >=Дата(2014,1,1) Тогда		
		Форма.мОтчетныйПериодПолугодие = Истина;		
	Иначе			
		Форма.мОтчетныйПериодПолугодие = Ложь;  		
	КонецЕсли;	          	

	//СтрПериодОтчета = ПредставлениеПериода(НачалоДня(Форма.мДатаНачалаПериодаОтчета), КонецДня(Форма.мДатаКонцаПериодаОтчета), "ФП = Истина" );
		
	Форма.НадписьПериодСоставленияОтчета = ПоказатьОсновнойПериод(Форма.мДатаНачалаПериодаОтчета, Форма.мДатаКонцаПериодаОтчета, Форма.мОтчетныйПериодПолугодие);

	КоличествоФорм = РегламентированнаяОтчетностьКлиентСервер.КоличествоФормСоответствующихВыбранномуПериоду(Форма);
	Если КоличествоФорм >= 1 Тогда

		Форма.Элементы.ОткрытьФормуОтчета.Доступность = Истина;

	Иначе		

		Форма.ОписаниеНормативДок = "";
		Форма.Элементы.ОткрытьФормуОтчета.Доступность = Ложь;
		
	КонецЕсли;

	РегламентированнаяОтчетностьКлиентСервер.ВыборФормыРегламентированногоОтчетаПоУмолчанию(Форма);

КонецПроцедуры

// Процедура устанавливает границы периода построения отчета.
//
// Параметры:
//  Шаг          - число, количество стандартных периодов, на которое необходимо
//                 сдвигать период построения отчета;
//
&НаКлиенте
Процедура ИзменитьПериод(Шаг)

	Если (мДатаНачалаПериодаОтчета + Шаг) >=Дата(2014,1,1) Тогда
		КратностьШагаПредыдущий = 6; // Полугодие		
	Иначе	
		КратностьШагаПредыдущий = 3; // Квартал		
	КонецЕсли;		

	мДатаНачалаПериодаОтчета = НачалоМесяца(ДобавитьМесяц(мДатаНачалаПериодаОтчета, Шаг*КратностьШагаПредыдущий));
	
	Если мДатаНачалаПериодаОтчета >=Дата(2014,1,1) Тогда		
		мОтчетныйПериодПолугодие = Истина;
		КратностьШага = 6; // Полугодие		
	Иначе			
		мОтчетныйПериодПолугодие = Ложь;
		КратностьШага = 3; // Квартал		
	КонецЕсли;		

	мДатаКонцаПериодаОтчета = КонецМесяца(ДобавитьМесяц(мДатаНачалаПериодаОтчета, КратностьШага-1));

	ПоказатьПериод(ЭтаФорма);

КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ПРОЦЕДУРЫ - ОБРАБОТЧИКИ СОБЫТИЙ ФОРМЫ

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Налогоплательщик         = Параметры.Налогоплательщик;
	мДатаНачалаПериодаОтчета = Параметры.мДатаНачалаПериодаОтчета;
	мДатаКонцаПериодаОтчета  = Параметры.мДатаКонцаПериодаОтчета;
	мПериодичность           = Параметры.мПериодичность;
	мСкопированаФорма        = Параметры.мСкопированаФорма;
	мСохраненныйДок          = Параметры.мСохраненныйДок;
	
	Если ЗначениеЗаполнено(Параметры.мВыбраннаяФорма) Тогда
		мПараметрыПрежнейФормы = Новый Структура("мВыбраннаяФорма, мСохраненныйДок, Налогоплательщик, мДатаНачалаПериодаОтчета, мДатаКонцаПериодаОтчета",
												Параметры.мВыбраннаяФорма, Параметры.мСохраненныйДок, Параметры.Налогоплательщик, Параметры.мДатаНачалаПериодаОтчета, Параметры.мДатаКонцаПериодаОтчета);
	КонецЕсли;	
	ИсточникОтчета = СтрЗаменить(СтрЗаменить(Строка(ЭтаФорма.ИмяФормы), "Отчет.", ""), ".Форма.ОсновнаяФорма", "");
	
	ТаблицаФормОтчета = РеквизитФормыВЗначение("ОтчетОбъект").ТаблицаФормОтчета();
	
	ЗначениеВДанныеФормы(ТаблицаФормОтчета, мТаблицаФормОтчета);
	
  		
	УчетПоВсемОрганизациям = РегламентированнаяОтчетностьПереопределяемый.ПолучитьПризнакУчетаПоВсемОрганизациям();
	ПеречислениеРазделыНалоговогоУчета = Перечисления.РазделыНалоговогоУчета.КПН;
	//Элементы.Организация.ТолькоПросмотр = НЕ УчетПоВсемОрганизациям;

	ОрганизацияПоУмолчанию = РегламентированнаяОтчетностьПереопределяемый.ПолучитьОрганизациюПоУмолчанию();
	
	ПеречислениеПериодичностьМесяц   = Перечисления.Периодичность.Месяц;
	ПеречислениеПериодичностьКвартал = Перечисления.Периодичность.Квартал;
		
	// Устанавливаем границы периода построения отчета как квартал
	// предшествующий текущему, нарастающим итогом с начала года.
	Если НЕ ЗначениеЗаполнено(мДатаНачалаПериодаОтчета) И НЕ ЗначениеЗаполнено(мДатаКонцаПериодаОтчета) Тогда
		
		Если ТекущаяДатаСеанса() >= Дата(2014,1,1) Тогда				
			// период полугодие
			мДатаНачалаПериодаОтчета = НачалоГода(ТекущаяДатаСеанса());
			мДатаКонцаПериодаОтчета  = КонецМесяца(ДобавитьМесяц(мДатаНачалаПериодаОтчета,5));
		Иначе
			// период квартал
			мДатаКонцаПериодаОтчета  = КонецКвартала(ТекущаяДатаСеанса());
			мДатаНачалаПериодаОтчета = НачалоКвартала(ТекущаяДатаСеанса());
		КонецЕсли;

	КонецЕсли;

	Если НЕ ЗначениеЗаполнено(мПериодичность) ИЛИ НЕ (мПериодичность = ПеречислениеПериодичностьМесяц ИЛИ мПериодичность = ПеречислениеПериодичностьКвартал) Тогда
		мПериодичность = ПеречислениеПериодичностьКвартал;
	КонецЕсли;

	ПоказатьПериод(ЭтаФорма);
	
	Если НЕ ЗначениеЗаполнено(Налогоплательщик) 
	   И ЗначениеЗаполнено(ОрганизацияПоУмолчанию) Тогда
		Налогоплательщик = ОрганизацияПоУмолчанию;
	КонецЕсли;	
	
	мПоддержкаРаботыСоСтруктурнымиПодразделениями = ПолучитьФункциональнуюОпцию("ПоддержкаРаботыСоСтруктурнымиПодразделениями");	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)

	// здесь отключаем стандартную обработку ПередЗакрытием формы
	// для подавления выдачи запроса на сохранение формы.
	СтандартнаяОбработка = Ложь;

КонецПроцедуры

&НаКлиенте
Процедура УстановитьПредыдущийПериод(Команда)
	
	ИзменитьПериод(-1);
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьСледующийПериод(Команда)
	
	ИзменитьПериод(1);
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьФормуОтчета(Команда)
	
	Если НЕ ЗначениеЗаполнено(Налогоплательщик) Тогда						
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(РегламентированнаяОтчетностьКлиент.ОсновнаяФормаОрганизацияНеЗаполненаВывестиТекст());				
		Возврат;		
	КонецЕсли;
	
	Если НЕ ЗначениеЗаполнено(мВыбраннаяФорма) Тогда				
		ТекстСообщения = НСтр("ru='Форма отчета для указанного периода не определена.'");
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения);				
		Возврат;		
	КонецЕсли;

	Если мСкопированаФорма <> Неопределено Тогда
		// Документ был скопиран. 
		// Проверяем соответствие форм.
		Если мВыбраннаяФорма <> мСкопированаФорма Тогда
			
			ПоказатьПредупреждение(,(НСтр("ru='Форма отчета изменилась, копирование невозможно!'")));
			Возврат;
						
		КонецЕсли;
	КонецЕсли;
	
// Основная форма была открыта из формы периода.
	Если мПараметрыПрежнейФормы <> Неопределено Тогда
		
		ТекстИзменений = НСтр("ru = 'Изменены параметры формирования отчета:'");
		ЕстьИзменения = Ложь;
		НеобходимоОткрытьНовуюФорму = Ложь;
		НеобходимоОчиститьФорму = Ложь;
		Если мПараметрыПрежнейФормы.Налогоплательщик <> Налогоплательщик Тогда
			ТекстИзменений = ТекстИзменений + НСТР("ru = 'налогоплательщик'");
			ЕстьИзменения = Истина;
			НеобходимоОчиститьФорму = Истина;
		КонецЕсли;	
				
		Если мПараметрыПрежнейФормы.мДатаНачалаПериодаОтчета <> мДатаНачалаПериодаОтчета ИЛИ мПараметрыПрежнейФормы.мДатаКонцаПериодаОтчета <> мДатаКонцаПериодаОтчета Тогда
			ТекстИзменений = ТекстИзменений + ?(ЕстьИзменения, НСТР("ru=' и '"), "") + НСТР("ru = 'отчетный период'");
			ЕстьИзменения = Истина;
			НеобходимоОчиститьФорму = Истина;
		КонецЕсли;	
						
		Если мПараметрыПрежнейФормы.мВыбраннаяФорма <> мВыбраннаяФорма Тогда
			ЕстьИзменения = Истина;
			НеобходимоОткрытьНовуюФорму = Истина;
		КонецЕсли; 
		
		Если ЕстьИзменения И НеобходимоОткрытьНовуюФорму Тогда			
			// форма открыта из формы отчета. При изменении формы периода требуется открыть новую форму			
			ТекстВопроса = ТекстИзменений + НСТР("ru = '. Будет закрыта форма текущего отчета и открыта новая форма, соответствующая данному периоду. Продолжить?'");			
			ОбработчикОповещенияОЗакрытии = Новый ОписаниеОповещения("ВопросОНеобходимостиЗакрытияПредыдущейФормы", ЭтотОбъект);


			ПоказатьВопрос(ОбработчикОповещенияОЗакрытии, ТекстВопроса, РежимДиалогаВопрос.ДаНет);		
			Возврат; // дальнейшие действия будут выполнены в обработке оповещения
			
		КонецЕсли;		
		
		Если ЕстьИзменения И НеобходимоОчиститьФорму Тогда
			// форма открыта из формы отчета. При изменении формы периода требуется открыть новую форму
			ТекстВопроса = ТекстИзменений + НСТР("ru = '. Данные в форме будут очищены! Продолжить?'");
			
			ОбработчикОповещенияОЗакрытии = Новый ОписаниеОповещения("ВопросОНеобходимостиОчисткиПредыдущейФормы", ЭтотОбъект);
			ПоказатьВопрос(ОбработчикОповещенияОЗакрытии, ТекстВопроса, РежимДиалогаВопрос.ДаНет);		
			Возврат; // дальнейшие действия будут выполнены в обработке оповещения
			
		КонецЕсли;	
	КонецЕсли;	
	            	
	ОткрытьВыбраннуюФорму();
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Функция ПоказатьОсновнойПериод(ТекДатаНачала, ТекДатаОкончания, ОтчетныйПериодПолугодие) Экспорт
	
	Если ОтчетныйПериодПолугодие Тогда
		Квартал 	= ?(Месяц(ТекДатаНачала)< 6, 1, 4); // для первого полугодия - 1 квартал, для второго - 4 квартал
		СтрПериодОтчета = СокрЛП(?(Квартал = 1, 1, 2)) + " полугодие " + СокрЛП(Формат(Год(ТекДатаНачала), "ЧГ=")) + " года";		
	Иначе	
		СтрПериодОтчета = ПредставлениеПериода(ТекДатаНачала, ТекДатаОкончания, "ФП = истина");
	КонецЕсли;
	
	Возврат СтрПериодОтчета;
		
КонецФункции

&НаКлиенте
Процедура ВопросОНеобходимостиЗакрытияПредыдущейФормы(РезультатВопроса, ДополнительныеПараметры) Экспорт
	
	Если РезультатВопроса <> КодВозвратаДиалога.Да Тогда
		Возврат;
	КонецЕсли;
	
	Если ВладелецФормы <> Неопределено Тогда
		ВладелецФормы.Модифицированность = Ложь; // Снимем влаг, чтобы подавить вопрос на сохранение данных при закрытии
		ВладелецФормы.Закрыть();
	КонецЕсли;
		
	мСохраненныйДок = Неопределено;
	
	ОткрытьВыбраннуюФорму(Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура ВопросОНеобходимостиОчисткиПредыдущейФормы(РезультатВопроса, ДополнительныеПараметры) Экспорт
	
	Если РезультатВопроса <> КодВозвратаДиалога.Да Тогда
		Возврат;
	КонецЕсли;
	
	Попытка
		ОсновнаяФорма = ВладелецФормы.СписокФормДерева.ПолучитьЭлементы()[0];
		КодОсновнойФормыВладельца 			   = ОсновнаяФорма.КодФормы;
		МногострочностьОсновнойФормыВладельца  = ОсновнаяФорма.Многострочность;	
		
		ВладелецФормы.ОчиститьРеглОтчетЗавершениеНаСервере(КодОсновнойФормыВладельца, МногострочностьОсновнойФормыВладельца, Истина);	

		//ВладелецФормы.Очистить(КодОсновнойФормыВладельца, Истина);
	Исключение
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru = 'Не удалось очистить отчет.'"));
	КонецПопытки;
	
	ОткрытьВыбраннуюФорму(Истина);
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьВыбраннуюФорму(ОбновитьПараметрыОткрытойФормы = Ложь)

	Если мПоддержкаРаботыСоСтруктурнымиПодразделениями Тогда		
		// для формы 300.00 нужны все структурные единицы налогоплательщика с учетом налогового комитета
		мСписокСтруктурныхЕдиниц = ПроцедурыНалоговогоУчетаВызовСервераПовтИсп.СформироватьСписокСтруктурныхЕдиниц(ПеречислениеРазделыНалоговогоУчета, Неопределено, Налогоплательщик);
	Иначе		
		// если в базе работа со структурными подразделениями не ведется, то налогоплательщик и структурная единица совпадают
		мСписокСтруктурныхЕдиниц.Очистить();
		мСписокСтруктурныхЕдиниц.Добавить(Налогоплательщик);
	КонецЕсли;
		
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("мДатаНачалаПериодаОтчета", мДатаНачалаПериодаОтчета);
	ПараметрыФормы.Вставить("мСохраненныйДок",          мСохраненныйДок);
	ПараметрыФормы.Вставить("мСкопированаФорма",        мСкопированаФорма);
	ПараметрыФормы.Вставить("мДатаКонцаПериодаОтчета",  мДатаКонцаПериодаОтчета);
	ПараметрыФормы.Вставить("мПериодичность",           мПериодичность);
	ПараметрыФормы.Вставить("Налогоплательщик",         Налогоплательщик);	
	ПараметрыФормы.Вставить("мВыбраннаяФорма",          мВыбраннаяФорма);
	ПараметрыФормы.Вставить("мСписокСтруктурныхЕдиниц", мСписокСтруктурныхЕдиниц);	
	
	Если ОбновитьПараметрыОткрытойФормы И ВладелецФормы <> Неопределено Тогда
		// при повторном открытии не выполняется создание формы на сервере
		// необходимо самостоятельно обновить параметры формы и зависимые данные
		ВладелецФормы.ОбновитьПараметрыФормыНаКлиенте(ПараметрыФормы);
	КонецЕсли;	
	
	Попытка
		Если ВладелецФормы  = Неопределено Тогда
			ОткрытьФорму(СтрЗаменить(ЭтаФорма.ИмяФормы, "ОсновнаяФорма", "") + мВыбраннаяФорма, ПараметрыФормы);
		Иначе
			ОткрытьФорму(СтрЗаменить(ЭтаФорма.ИмяФормы, "ОсновнаяФорма", "") + мВыбраннаяФорма, ПараметрыФормы,,ВладелецФормы.КлючУникальности);
		КонецЕсли;		
		Закрыть(); // закрываем основную форму
	Исключение
		ТекстСообщения = НСтр("ru='Форма отчета для указанного периода не определена.'");
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения);		
	КонецПопытки;	
		  	
КонецПроцедуры
