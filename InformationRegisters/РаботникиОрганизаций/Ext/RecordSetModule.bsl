﻿
#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

////////////////////////////////////////////////////////////////////////////////
// ПРОЦЕДУРЫ - ОБРАБОТЧИКИ СОБЫТИЙ

Процедура ПередЗаписью(Отказ, Замещение)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Регистратор = Отбор.Регистратор.Значение;
	
	Запрос = Новый Запрос;
	МенеджерВТ = Новый МенеджерВременныхТаблиц;
	Запрос.МенеджерВременныхТаблиц = МенеджерВТ;
	Запрос.УстановитьПараметр("Регистратор", Регистратор);
	
	Запрос.Текст = "ВЫБРАТЬ
	               |	РаботникиОрганизаций.Сотрудник
				   |ПОМЕСТИТЬ ВТ_ВнешнийИсточник
	               |ИЗ
	               |	РегистрСведений.РаботникиОрганизаций КАК РаботникиОрганизаций
	               |ГДЕ
	               |	РаботникиОрганизаций.Регистратор = &Регистратор";
				   
	Результат = Запрос.Выполнить();
	
	Если НЕ Результат.Пустой() Тогда
		ДополнительныеСвойства.Вставить("МенеджерВТ", МенеджерВТ);
	КонецЕсли;
	
КонецПроцедуры

Процедура ПриЗаписи(Отказ, Замещение)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	УстановитьПривилегированныйРежим(Истина);
	Регистратор = Отбор.Регистратор.Значение;
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Регистратор", Регистратор);

	СписокСотрудниковТекст = "";
	Если ДополнительныеСвойства.Свойство("МенеджерВТ")  Тогда
		
		Запрос.МенеджерВременныхТаблиц = ДополнительныеСвойства.МенеджерВТ;
		
		СписокСотрудниковТекст = 
			"ВЫБРАТЬ РАЗЛИЧНЫЕ
			|	СписокСотрудников.Сотрудник КАК Сотрудник
			|ПОМЕСТИТЬ ВТ_СписокСотрудников
			|ИЗ ВТ_ВнешнийИсточник КАК СписокСотрудников
			|
			|ОБЪЕДИНИТЬ  // Дополнять список будем только сотрудниками, которых еще нет
			|";
			
	КонецЕсли;
	
	ТаблицаНаборЗаписей = Выгрузить(,"Сотрудник, Период, ОбособленноеПодразделение, ПодразделениеОрганизации, СтруктурноеПодразделение, Должность, ПричинаИзмененияСостояния");
	
	Запрос.УстановитьПараметр("ТаблицаНаборЗаписей", ТаблицаНаборЗаписей);
	
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	Наборзаписей.Сотрудник,
		|	Наборзаписей.Период,
		|	Наборзаписей.ПодразделениеОрганизации,
		|	Наборзаписей.Должность,
		|	Наборзаписей.ОбособленноеПодразделение,
		|	Наборзаписей.СтруктурноеПодразделение,
		|	Наборзаписей.ПричинаИзмененияСостояния
		|ПОМЕСТИТЬ ВТ_НаборЗаписей
		|ИЗ &ТаблицаНаборЗаписей КАК НаборЗаписей
		|ИНДЕКСИРОВАТЬ ПО
		|	Сотрудник
		|;
		|////////////////////////////////////////////////////////////////////////////////
		|
		|" + СписокСотрудниковТекст + "
		|
		|ВЫБРАТЬ " + ?(СписокСотрудниковТекст = "", "РАЗЛИЧНЫЕ", "") + " 		
		|	НаборЗаписей.Сотрудник" + ?(СписокСотрудниковТекст = "", "
		|ПОМЕСТИТЬ ВТ_СписокСотрудников", "") + "
		|ИЗ
		|	ВТ_НаборЗаписей КАК НаборЗаписей
		|
		|ИНДЕКСИРОВАТЬ ПО
		|	Сотрудник
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	СписокСотрудников.Сотрудник,
		|	НаборЗаписей.Период,
		|	НаборЗаписей.ПодразделениеОрганизации,
		|	НаборЗаписей.Должность,
		|	НаборЗаписей.ОбособленноеПодразделение,
		|	НаборЗаписей.СтруктурноеПодразделение,
		|	НаборЗаписей.ПричинаИзмененияСостояния
		|ПОМЕСТИТЬ ВТ_ДанныеПроведения
		|ИЗ
		|	ВТ_НаборЗаписей КАК НаборЗаписей
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВТ_СписокСотрудников КАК СписокСотрудников
		|		ПО НаборЗаписей.Сотрудник = СписокСотрудников.Сотрудник
		|
		|ИНДЕКСИРОВАТЬ ПО
		|	СписокСотрудников.Сотрудник
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	СписокСотрудников.Сотрудник,
		|	ЕСТЬNULL(ДанныеПриема.Период, ДАТАВРЕМЯ(1, 1, 1)) КАК ДатаПриемаНаРаботу,
		|	ЕСТЬNULL(ДанныеУвольнения.Период, ДАТАВРЕМЯ(1, 1, 1)) КАК ДатаУвольнения,
		|	ВЫБОР
		|		КОГДА ДанныеПроведения.Сотрудник ЕСТЬ NULL 
		|			ТОГДА ЕСТЬNULL(АктуальныеДанные.ПодразделениеОрганизации, ЗНАЧЕНИЕ(Справочник.ПодразделенияОрганизаций.ПустаяСсылка))
		|		КОГДА НЕ АктуальныеДанные.Период ЕСТЬ NULL 
		|				И АктуальныеДанные.Период <= ДанныеПроведения.Период
		|			ТОГДА ДанныеПроведения.ПодразделениеОрганизации
		|		ИНАЧЕ ЕСТЬNULL(АктуальныеДанные.ПодразделениеОрганизации, ЗНАЧЕНИЕ(Справочник.ПодразделенияОрганизаций.ПустаяСсылка))
		|	КОНЕЦ КАК ТекущееПодразделениеОрганизации,
		|	ВЫБОР
		|		КОГДА ДанныеПроведения.Сотрудник ЕСТЬ NULL 
		|			ТОГДА ЕСТЬNULL(АктуальныеДанные.Должность, ЗНАЧЕНИЕ(Справочник.ДолжностиОрганизаций.ПустаяСсылка))
		|		КОГДА НЕ АктуальныеДанные.Период ЕСТЬ NULL 
		|				И АктуальныеДанные.Период <= ДанныеПроведения.Период
		|			ТОГДА ДанныеПроведения.Должность
		|		ИНАЧЕ ЕСТЬNULL(АктуальныеДанные.Должность, ЗНАЧЕНИЕ(Справочник.ДолжностиОрганизаций.ПустаяСсылка))
		|	КОНЕЦ КАК ТекущаяДолжностьОрганизации,
		|	ВЫБОР
		|		КОГДА ДанныеПроведения.Сотрудник ЕСТЬ NULL 
		|			ТОГДА ЕСТЬNULL(АктуальныеДанные.ОбособленноеПодразделение, ЗНАЧЕНИЕ(Справочник.Организации.ПустаяСсылка))
		|		КОГДА НЕ АктуальныеДанные.Период ЕСТЬ NULL 
		|				И АктуальныеДанные.Период <= ДанныеПроведения.Период
		|			ТОГДА ДанныеПроведения.ОбособленноеПодразделение
		|		ИНАЧЕ ЕСТЬNULL(АктуальныеДанные.ОбособленноеПодразделение, ЗНАЧЕНИЕ(Справочник.Организации.ПустаяСсылка))
		|	КОНЕЦ КАК ТекущаяСтруктурнаяЕдиница,
		|	ВЫБОР
		|		КОГДА ДанныеПроведения.Сотрудник ЕСТЬ NULL 
		|			ТОГДА ЕСТЬNULL(АктуальныеДанные.СтруктурноеПодразделение, ЗНАЧЕНИЕ(Справочник.ПодразделенияОрганизаций.ПустаяСсылка))
		|		КОГДА НЕ АктуальныеДанные.Период ЕСТЬ NULL 
		|				И АктуальныеДанные.Период <= ДанныеПроведения.Период
		|			ТОГДА ДанныеПроведения.СтруктурноеПодразделение
		|		ИНАЧЕ ЕСТЬNULL(АктуальныеДанные.СтруктурноеПодразделение, ЗНАЧЕНИЕ(Справочник.ПодразделенияОрганизаций.ПустаяСсылка))
		|	КОНЕЦ КАК ТекущееСтруктурноеПодразделение
		|ИЗ
		|	ВТ_СписокСотрудников КАК СписокСотрудников
		|		
		|		ЛЕВОЕ СОЕДИНЕНИЕ ВТ_ДанныеПроведения КАК ДанныеПроведения
		|		ПО СписокСотрудников.Сотрудник = ДанныеПроведения.Сотрудник
		|
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.РаботникиОрганизаций.СрезПоследних(
		|				,
		|				Сотрудник В
		|						(ВЫБРАТЬ
		|							СписокСотрудников.Сотрудник
		|						ИЗ
		|							ВТ_СписокСотрудников КАК СписокСотрудников)
		|					И ПричинаИзмененияСостояния = ЗНАЧЕНИЕ(Перечисление.ПричиныИзмененияСостояния.ПриемНаРаботу)) КАК ДанныеПриема
		|		ПО СписокСотрудников.Сотрудник = ДанныеПриема.Сотрудник
		|
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.РаботникиОрганизаций.СрезПоследних(
		|				,
		|				Сотрудник В
		|						(ВЫБРАТЬ
		|							СписокСотрудников.Сотрудник
		|						ИЗ
		|							ВТ_СписокСотрудников КАК СписокСотрудников)
		|					И ПричинаИзмененияСостояния = ЗНАЧЕНИЕ(Перечисление.ПричиныИзмененияСостояния.Увольнение)) КАК ДанныеУвольнения
		|		ПО СписокСотрудников.Сотрудник = ДанныеУвольнения.Сотрудник
		|
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.РаботникиОрганизаций.СрезПоследних(
		|				,
		|				Сотрудник В
		|					(ВЫБРАТЬ
		|						СписокСотрудников.Сотрудник
		|					ИЗ
		|						ВТ_СписокСотрудников КАК СписокСотрудников)) КАК АктуальныеДанные
		|		ПО СписокСотрудников.Сотрудник = АктуальныеДанные.Сотрудник
		|ГДЕ
		|	(ДанныеПроведения.Сотрудник ЕСТЬ NULL 
		|			ИЛИ (НЕ АктуальныеДанные.Период ЕСТЬ NULL 
		|				И АктуальныеДанные.Период <= ДанныеПроведения.Период)
		|			ИЛИ ДанныеПроведения.ПричинаИзмененияСостояния = ЗНАЧЕНИЕ(Перечисление.ПричиныИзмененияСостояния.ПриемНаРаботу))
		|";
		
	Выборка = Запрос.Выполнить().Выбрать();
		
	Пока Выборка.Следующий() Цикл
		
		СотрудникОбъект = Выборка.Сотрудник.ПолучитьОбъект();
		
		Если СотрудникОбъект = Неопределено Тогда
			Продолжить;
		КонецЕсли;
		
		Попытка
			СотрудникОбъект.Заблокировать();
		Исключение
			#Если ТолстыйКлиентОбычноеПриложение Тогда
				ОбщегоНазначенияБККлиентСервер.СообщитьОбОшибке(ИнформацияОбОшибке());
			# Иначе
				ОбщегоНазначенияБККлиентСервер.СообщитьОбОшибке(ИнформацияОбОшибке().Описание);
			# КонецЕсли
			Отказ = Истина;
			Продолжить;
		КонецПопытки;
		
		Если Отказ Тогда
			Продолжить;
		КонецЕсли;
		
		ЗаполнитьЗначенияСвойств(СотрудникОбъект, Выборка);
		
		СотрудникОбъект.Записать();
		
	КонецЦикла;
	
КонецПроцедуры

#КонецЕсли