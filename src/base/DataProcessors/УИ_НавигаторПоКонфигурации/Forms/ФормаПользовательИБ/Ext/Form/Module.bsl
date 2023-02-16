﻿&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	УстановитьПривилегированныйРежим(Истина);

	Если Параметры.Свойство("РежимРаботы") Тогда
		_РежимРаботы = Параметры.РежимРаботы;
	КонецЕсли;

	Если _РежимРаботы = 0 Тогда
		Идентификатор = Параметры.ИдентификаторПользователяИБ;
		ИдентификаторПользователяИБ = Новый УникальныйИдентификатор(Параметры.ИдентификаторПользователяИБ);

		Попытка
			ПользовательИБ = ПользователиИнформационнойБазы.НайтиПоУникальномуИдентификатору(
				ИдентификаторПользователяИБ);
			Если ПользовательИБ = Неопределено Тогда
				Отказ = Истина;
			КонецЕсли;
		Исключение
			Отказ = Истина;
		КонецПопытки;

	ИначеЕсли _РежимРаботы = 1 Тогда
		ПользовательИБ = ПользователиИнформационнойБазы.СоздатьПользователя();
		Элементы.ИзменитьПароль.Доступность = Ложь;
		Заголовок = "Создание";

	ИначеЕсли _РежимРаботы = 2 Тогда
		Идентификатор = Параметры.ИдентификаторПользователяИБ;
		ИдентификаторПользователяИБ = Новый УникальныйИдентификатор(Параметры.ИдентификаторПользователяИБ);

		Попытка
			ПользовательИБ = ПользователиИнформационнойБазы.НайтиПоУникальномуИдентификатору(
				ИдентификаторПользователяИБ);
			Если ПользовательИБ = Неопределено Тогда
				Отказ = Истина;
			КонецЕсли;
		Исключение
			Отказ = Истина;
		КонецПопытки;

		Элементы.ИзменитьПароль.Доступность = Ложь;
		Заголовок = "Создание";
	Иначе
		Отказ = Истина;
	КонецЕсли;

	Если Не Отказ Тогда
		ЗаполнитьЗначенияСвойств(ЭтаФорма, ПользовательИБ, , "Пароль");

		Струк = вЗначениеСвойств(ПользовательИБ, "ЗащитаОтОпасныхДействий");
		Если Струк.ЗащитаОтОпасныхДействий <> Неопределено Тогда
			ЗащитаОтОпасныхДействий = ПользовательИБ.ЗащитаОтОпасныхДействий.ПредупреждатьОбОпасныхДействиях;
		Иначе
			ЗащитаОтОпасныхДействий = Ложь;
			Элементы.ЗащитаОтОпасныхДействий.ТолькоПросмотр = Истина;
		КонецЕсли;

		Если ПользовательИБ.ПарольУстановлен Тогда
			Пароль = "12345";
			ПодтверждениеПароля = "54321";
		КонецЕсли;

		Для Каждого Элем Из Метаданные.Роли Цикл
			НС = РолиПользователя.Добавить();
			НС.Имя = Элем.Имя;
			НС.Представление = Элем.Представление();
			Если ПользовательИБ.Роли.Содержит(Элем) Тогда
				НС.Пометка = Истина;
				НС.Присвоена = Истина;
				Если _РежимРаботы = 2 Тогда
					НС.Присвоена = Ложь;
				КонецЕсли;
			КонецЕсли;
		КонецЦикла;

		РолиПользователя.Сортировать("Имя");

	КонецЕсли;
КонецПроцедуры

&НаСервереБезКонтекста
Функция вЗначениеСвойств(Знач Объект, ПереченьСвойств)
	Струк = Новый Структура(ПереченьСвойств);
	ЗаполнитьЗначенияСвойств(Струк, Объект);

	Возврат Струк;
КонецФункции

&НаСервере
Процедура ЗаписатьОбъектНаСервере()
	Если _РежимРаботы = 0 Тогда
		ПользовательИБ = ПользователиИнформационнойБазы.НайтиПоУникальномуИдентификатору(ИдентификаторПользователяИБ);
	Иначе
		ПользовательИБ = ПользователиИнформационнойБазы.СоздатьПользователя();
		ПользовательИБ.Пароль = Пароль;
	КонецЕсли;

	Если Не Элементы.ЗащитаОтОпасныхДействий.ТолькоПросмотр Тогда
		ЗаполнитьЗначенияСвойств(ПользовательИБ, ЭтаФорма, , "Пароль, ЗащитаОтОпасныхДействий");
		ПользовательИБ.ЗащитаОтОпасныхДействий.ПредупреждатьОбОпасныхДействиях = ЗащитаОтОпасныхДействий;
	Иначе
		ЗаполнитьЗначенияСвойств(ПользовательИБ, ЭтаФорма, , "Пароль");
	КонецЕсли;

	Для Каждого Стр Из РолиПользователя.НайтиСтроки(Новый Структура("Пометка, Присвоена", Истина, Ложь)) Цикл
		ПользовательИБ.Роли.Добавить(Метаданные.Роли[Стр.Имя]);
	КонецЦикла;

	Для Каждого Стр Из РолиПользователя.НайтиСтроки(Новый Структура("Пометка, Присвоена", Ложь, Истина)) Цикл
		ПользовательИБ.Роли.Удалить(Метаданные.Роли[Стр.Имя]);
	КонецЦикла;

	ПользовательИБ.Записать();
КонецПроцедуры

&НаКлиенте
Процедура ЗаписатьОбъект(Команда)
	Если _РежимРаботы <> 0 Тогда
		Если Пароль <> ПодтверждениеПароля Тогда
			ПоказатьПредупреждение( , "Пароль не совпадает с Подтверждением пароля!", 10);
			Возврат;
		КонецЕсли;
	КонецЕсли;

	Попытка
		ЗаписатьОбъектНаСервере();
		Закрыть();
	Исключение
		Сообщить(ОписаниеОшибки());
	КонецПопытки;
КонецПроцедуры

&НаСервере
Процедура ИзменитьПарольНаСервере()
	ПользовательИБ = ПользователиИнформационнойБазы.НайтиПоУникальномуИдентификатору(ИдентификаторПользователяИБ);
	ПользовательИБ.Пароль = Пароль;
	ПользовательИБ.Записать();
КонецПроцедуры

&НаКлиенте
Процедура ИзменитьПароль(Команда)
	Если Пароль <> ПодтверждениеПароля Тогда
		ПоказатьПредупреждение( , "Пароль не совпадает с Подтверждением пароля!", 10);
		Возврат;
	КонецЕсли;

	ИзменитьПарольНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура _ПоказатьТолькоДоступные(Команда)
	ЭФ = Элементы.РолиПользователя_ПоказатьТолькоДоступные;
	ЭФ.Пометка = Не Эф.Пометка;

	Если ЭФ.Пометка Тогда
		Элементы.РолиПользователя.ОтборСтрок = Новый ФиксированнаяСтруктура(Новый Структура("Пометка", Истина));
	Иначе
		Элементы.РолиПользователя.ОтборСтрок = Неопределено;
	КонецЕсли;
КонецПроцедуры