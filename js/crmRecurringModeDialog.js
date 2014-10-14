(function ($, _, undefined) {
  $.fn.crmRecurringModeDialog = function ( options ) {
    console.log(options);
    if (!options.entityID || !options.entityTable || !options.mapper) {
      CRM.console('error', 'Error: describe error');
      return false;
    }
    // fixme: throw error if this type is not button
    $(this).click(function() {
      form = $(this).parents('form:first').attr('class');
      if( form != "" && options.mapper.hasOwnProperty(form) ){
        $("#recurring-dialog").dialog({
          title: 'How does this change affect other repeating entities in the set?',
          modal: true,
          width: '650',
          buttons: {
            Cancel: function() { //cancel
              $( this ).dialog( "close" );
            }
          }
        }).dialog('open');
        return false;
      }
    });
  };
})(jQuery, _);
