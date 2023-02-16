﻿&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Попытка
		Значение = ЗначениеИзСтрокиВнутр(Параметры.ЗначениеВнутр);
	Исключение
		Сообщить(КраткоеПредставлениеОшибки(ИнформацияОбОшибке()));
		Отказ = Истина;
		Возврат;
	КонецПопытки;

	Если ТипЗнч(Значение) <> Тип("ТаблицаЗначений") Тогда
		Отказ = Истина;
		Возврат;
	КонецЕсли;

	_ЧислоЗаписей = Значение.Количество();
	
	ТипХЗ = Тип("ХранилищеЗначения");
	ТипТЗ = Тип("ТаблицаЗначений");
	ТипТТ = Тип("Тип");
	ТипМВ = Тип("МоментВремени");

	РеквизитыКДобавлению = Новый Массив;
	РеквизитыКУдалению = Новый Массив;

	Для Каждого Колонка Из Значение.Колонки Цикл
		//Если не Колонка.ТипЗначения.СодержитТип(пТипТаблицаЗначений) Тогда
		//	РеквизитыКДобавлению.Добавить(новый РеквизитФормы(Колонка.Имя, Колонка.ТипЗначения, "ТаблицаДанных", Колонка.Заголовок, ложь));
		//КонецЕсли;

		Если Колонка.ТипЗначения.СодержитТип(ТипХЗ) Тогда
			ТипЗначенияРеквизита = Новый ОписаниеТипов;
		ИначеЕсли Колонка.ТипЗначения.СодержитТип(ТипТЗ) Тогда
			ТипЗначенияРеквизита = Новый ОписаниеТипов;
		ИначеЕсли Колонка.ТипЗначения.СодержитТип(ТипТТ) Тогда
			ТипЗначенияРеквизита = Новый ОписаниеТипов;
		ИначеЕсли Колонка.ТипЗначения.СодержитТип(ТипМВ) Тогда
			ТипЗначенияРеквизита = Новый ОписаниеТипов;
		Иначе
			ТипЗначенияРеквизита = Колонка.ТипЗначения;
		КонецЕсли;

		РеквизитыКДобавлению.Добавить(Новый РеквизитФормы(Колонка.Имя, ТипЗначенияРеквизита, "ТаблицаДанных",
			Колонка.Заголовок, Ложь));
	КонецЦикла;

	ИзменитьРеквизиты(РеквизитыКДобавлению, РеквизитыКУдалению);
	ЗначениеВРеквизитФормы(Значение, "ТаблицаДанных");

	Для Каждого Колонка Из Значение.Колонки Цикл
		//Если не Колонка.ТипЗначения.СодержитТип(пТипТаблицаЗначений) Тогда
		ЭтаФорма.Элементы.Добавить(Колонка.Имя, Тип("ПолеФормы"), ЭтаФорма.Элементы.ТаблицаДанных);
		ЭтаФорма.Элементы[Колонка.Имя].ПутьКДанным = "ТаблицаДанных." + Колонка.Имя;
		ЭтаФорма.Элементы[Колонка.Имя].Вид = ВидПоляФормы.ПолеВвода;
		ЭтаФорма.Элементы[Колонка.Имя].ДоступныеТипы = Колонка.ТипЗначения;
		//КонецЕсли;
	КонецЦикла;

	Если Не ПустаяСтрока(Параметры.Заголовок) Тогда
		ЭтаФорма.Заголовок = Параметры.Заголовок;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура КомандаОК(Команда)
	Результат = Новый Структура;
	Результат.Вставить("ТипЗначения", "ТаблицаЗначений");
	Результат.Вставить("СтрокаВнутр", вТаблицаДанныхКакСтрокаВнутр());
	Закрыть(Результат);
КонецПроцедуры

&НаКлиенте
Процедура КомандаЗакрыть(Команда)
	Закрыть();
КонецПроцедуры

&НаКлиенте
Процедура КомандаОчиститьТаблицу(Команда)
	ТаблицаДанных.Очистить();
КонецПроцедуры

&НаСервере
Функция вТаблицаДанныхКакСтрокаВнутр()
	Возврат ЗначениеВСтрокуВнутр(РеквизитФормыВЗначение("ТаблицаДанных"));
КонецФункции