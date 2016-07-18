$(document).on('ready page:change', function() {
  $('.datetimepicker').datetimepicker({
    // put here your custom picker options, that should be applied for all pickers
    // format: false,
    // dayViewHeaderFormat: 'MMMM YYYY',
    // extraFormats: false,
    // stepping: 1,
    // minDate: false,
    // maxDate: false,
    // useCurrent: true,
    // collapse: true,
    // locale: moment.locale(),
    // defaultDate: false,
    // disabledDates: false,
    // enabledDates: false,
    // icons: {
    //   time: 'glyphicon glyphicon-time',
    //   date: 'glyphicon glyphicon-calendar',
    //   up: 'glyphicon glyphicon-chevron-up',
    //   down: 'glyphicon glyphicon-chevron-down',
    //   previous: 'glyphicon glyphicon-chevron-left',
    //   next: 'glyphicon glyphicon-chevron-right',
    //   today: 'glyphicon glyphicon-screenshot',
    //   clear: 'glyphicon glyphicon-trash',
    //   close: 'glyphicon glyphicon-remove'
    // },
    // useStrict: false,
    // sideBySide: false,
    // daysOfWeekDisabled: [],
    // calendarWeeks: false,
    // viewMode: 'days',
    // toolbarPlacement: 'default',
    // showTodayButton: false,
    // showClear: false,
    // showClose: false,
    // widgetPositioning: {
    //   horizontal: 'auto',
    //   vertical: 'auto'
    // },
    // widgetParent: null,
    // ignoreReadonly: false,
    // keepOpen: false,
    // inline: false,
    // keepInvalid: false,
    // datepickerInput: '.datepickerinput'
    icons: {
      date: 'fa fa-calendar',
      time: 'fa fa-clock-o',
      up: 'fa fa-chevron-up',
      down: 'fa fa-chevron-down',
      previous: 'fa fa-chevron-left',
      next: 'fa fa-chevron-right',
      today: 'fa fa-crosshairs',
      clear: 'fa fa-trash-o',
      close: 'fa fa-times'
    }
  });

  $('.datetimerange').each(function(){
    var $this = $(this)
    var range1 = $($this.find('.input-group')[0])
    var range2 = $($this.find('.input-group')[1])

    if(range1.data("DateTimePicker").date() != null)
      range2.data("DateTimePicker").minDate(range1.data("DateTimePicker").date());

    if(range2.data("DateTimePicker").date() != null)
      range1.data("DateTimePicker").maxDate(range2.data("DateTimePicker").date());

    range1.on("dp.change",function (e) {
      if(e.date)
        range2.data("DateTimePicker").minDate(e.date);
      else
        range2.data("DateTimePicker").minDate(false);
    });

    range2.on("dp.change",function (e) {
      if(e.date)
        range1.data("DateTimePicker").maxDate(e.date);
      else
        range1.data("DateTimePicker").maxDate(false);
    });
  })
});
