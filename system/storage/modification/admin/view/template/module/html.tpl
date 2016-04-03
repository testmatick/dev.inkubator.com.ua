<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-html" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-html" class="form-horizontal">
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-name"><?php echo $entry_name; ?></label>
            <div class="col-sm-10">
              <input type="text" name="name" value="<?php echo $name; ?>" placeholder="<?php echo $entry_name; ?>" id="input-name" class="form-control" />
              <?php if ($error_name) { ?>
              <div class="text-danger"><?php echo $error_name; ?></div>
              <?php } ?>
            </div>
          </div>         
          <div class="tab-pane">
            <ul class="nav nav-tabs" id="language">
              <?php foreach ($languages as $language) { ?>
              <li><a href="#language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
              <?php } ?>
            </ul>
            <div class="tab-content">
              <?php foreach ($languages as $language) { ?>
              <div class="tab-pane" id="language<?php echo $language['language_id']; ?>">
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-title<?php echo $language['language_id']; ?>"><?php echo $entry_title; ?></label>
                  <div class="col-sm-10">
                    <input type="text" name="module_description[<?php echo $language['language_id']; ?>][title]" placeholder="<?php echo $entry_title; ?>" id="input-heading<?php echo $language['language_id']; ?>" value="<?php echo isset($module_description[$language['language_id']]['title']) ? $module_description[$language['language_id']]['title'] : ''; ?>" class="form-control" />
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-description<?php echo $language['language_id']; ?>"><?php echo $entry_description; ?></label>
                  <div class="col-sm-10">
                    <textarea name="module_description[<?php echo $language['language_id']; ?>][description]" placeholder="<?php echo $entry_description; ?>" id="input-description<?php echo $language['language_id']; ?>" class="form-control"><?php echo isset($module_description[$language['language_id']]['description']) ? $module_description[$language['language_id']]['description'] : ''; ?></textarea>
                  </div>
                </div>
              </div>
              <?php } ?>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
            <div class="col-sm-10">
              <select name="status" id="input-status" class="form-control">
                <?php if ($status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
  <script type="text/javascript"><!--
<?php foreach ($languages as $language) { ?>

<?php } ?>
//--></script> 
  <script type="text/javascript"><!--
$('#language a:first').tab('show');
//--></script></div>
<script src="view/javascript/ckeditor/ckeditor.js"></script>
<script src="view/javascript/ckeditor/adapters/jquery.js"></script>
<script type="text/javascript">
<?php foreach ($languages as $language) { ?>
CKEDITOR.replace('input-description<?php echo $language['language_id']; ?>', {
	language: '<?php echo $language_code; ?>',
	on: {
		instanceReady: function(evt) {
			$('#cke_input-description<?php echo $language['language_id']; ?>').after('<input type="hidden" id="filemanager<?php echo $language['language_id']; ?>" value="" />');
			$('#cke_input-description<?php echo $language['language_id']; ?> .cke_button__image').before('<a href="javascript:;" class="filemanager cke_button" title="<?php echo $text_filemanager; ?>"><span class="cke_button_icon">&nbsp;</span></a>');
			$(document).on('click', '#cke_input-description<?php echo $language['language_id']; ?> .filemanager', function() {
				$('#modal-image').remove();
				$.ajax({
					url: 'index.php?route=common/filemanager&token=<?php echo $token; ?>&target=filemanager<?php echo $language['language_id']; ?>',
					dataType: 'html',
					success: function(html) {
						$('body').append('<div id="modal-image" class="modal filemanager<?php echo $language['language_id']; ?>">' + html + '</div>');
						$('#modal-image').modal('show');
					}
				});
			});
			$('body').on('click', '.filemanager<?php echo $language['language_id']; ?> .thumbnail', function (){
				$('#modal-image').removeClass('filemanager<?php echo $language['language_id']; ?>');
				evt.editor.focus();
				evt.editor.insertHtml('<img src="<?php echo HTTPS_CATALOG . 'image/'; ?>' + $('#filemanager<?php echo $language['language_id']; ?>').val() + '" alt="" />');
			});
		}
	}
});
<?php } ?>
</script>
<style>
.filemanager > .cke_button_icon {background-image: url('view/javascript/ckeditor/plugins/filemanager/icon.png'); background-size: auto;}
.filemanager:hover {background-color: #D5E1F2;}
</style>
<?php echo $footer; ?>