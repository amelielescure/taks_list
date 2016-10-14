class Tasks
  showDatePicker: (task_id) ->
    AUTH_TOKEN = $('meta[name=csrf-token]').attr('content');
    $('#task-' + task_id + ' .js-datapicker_block').html('<div class="row">' +
      '<form action="/tasks/' + task_id + '/postpone?&authenticity_token=' + AUTH_TOKEN + '" method="post" data-remote="true">' +
        ' <div class="col-sm-5">' +
            '<input type="text" class="form-control datepicker" name="task[postpone_date]">' +
          '</div>' +
          '<div class="col-sm-4">' +
            '<input class="btn btn-success" type="submit" value="OK">' +
            '<a class="btn btn-default js-close-postpone" data-id="' + task_id + '">X</a>' +
          '</div>' +
        '</div>' +
      '</form>')

    dateToday = new Date();
    $('.datepicker').datepicker({dateFormat: "dd-mm-yy", minDate: dateToday })

  hideDatePicker: (task_id) ->
    $('#task-' + task_id + ' .js-datapicker_block').html('<button class="btn btn-default js-postpone" data-id="' + task_id + '">Remettre à plus tard</button>')

$(document).on 'ready page:load', ->
  tasks = new Tasks

  $(document).on 'click', '.js-postpone', (e) ->
    tasks.showDatePicker( $(e.currentTarget).data('id') )

  $(document).on 'click', '.js-close-postpone', (e) ->
    tasks.hideDatePicker( $(e.currentTarget).data('id') )

