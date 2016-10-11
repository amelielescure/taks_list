class Tasks
  showDatePicker: (task_id) ->
    $('#task-' + task_id + ' .js-datapicker_block').html('<div class="input-group date col-sm-5" data-provide="datepicker">' +
                                                            '<input type="text" class="datepicker form-control" data-date-format="dd/mm/yyyy">' +
                                                            '<div class="input-group-addon">' +
                                                                '<span class="glyphicon glyphicon-th"></span>' +
                                                            '</div>' +
                                                          '</div>');
    $('.datepicker').datepicker();


$ ->
  tasks = new Tasks

  $('#tasks_list .js-postpone').on 'click', (e) ->
    id = $(e.currentTarget).data('id')
    tasks.showDatePicker(id)
