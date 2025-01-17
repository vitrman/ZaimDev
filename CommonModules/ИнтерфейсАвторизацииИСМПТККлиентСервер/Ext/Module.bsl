﻿
// Инициализировать структуру параметров запроса в ИС МОТП (ИС МП) для получения ключа сессии.
// 
// Возвращаемое значение:
// 	Структура - Описание:
// * Организация          - ОпределяемыйТип.Организация - Организация от имени которой необходимо авторизоваться.
// * ПредставлениеСервиса - Строка                      - Представление сервиса, например: ИС МОТП.
// * Сервер               - Строка                      - Адрес сервера, например: stable.ismotp.crpt.ru
// * Порт                 - Число                       - Например: 443.
// * АдресЗапросаКлючаСессии           - Строка - Например: api/v3/auth/cert/
// * АдресЗапросаПараметровАвторизации - Строка - Например: api/v3/auth/cert/key
//
Функция ПараметрыЗапросаКлючаСессии() Экспорт
	
	ПараметрыЗапроса = Новый Структура;
	ПараметрыЗапроса.Вставить("ПредставлениеСервиса",            "");
	ПараметрыЗапроса.Вставить("Организация",                     Неопределено);
	
	ПараметрыЗапроса.Вставить("Сервер",                           "");
	ПараметрыЗапроса.Вставить("Порт",                             443);
	ПараметрыЗапроса.Вставить("Таймаут",                          60);
	ПараметрыЗапроса.Вставить("ИспользоватьЗащищенноеСоединение", Истина);
	
	ПараметрыЗапроса.Вставить("ИмяПараметраСеанса",                "");
	ПараметрыЗапроса.Вставить("АдресЗапросаПараметровАвторизации", "api/v3/auth/cert/key");
	ПараметрыЗапроса.Вставить("АдресЗапросаКлючаСессии",           "api/v3/auth/cert/");
	
	Возврат ПараметрыЗапроса;
	
КонецФункции
