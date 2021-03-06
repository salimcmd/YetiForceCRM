{*<!--
/*+**********************************************************************************
 * The contents of this file are subject to the vtiger CRM Public License Version 1.1
 * ("License"); You may not use this file except in compliance with the License
 * The Original Code is:  vtiger CRM Open Source
 * The Initial Developer of the Original Code is vtiger.
 * Portions created by vtiger are Copyright (C) vtiger.
 * All Rights Reserved.
 * Contributor(s): YetiForce.com
 ************************************************************************************/
-->*}
{literal} 
<script type="text/javascript">
	YetiForce_Bar_Widget_Js('YetiForce_Leadsbysource_Widget_Js',{},{
		registerSectionClick : function() {	
			var thisInstance = this;
			var chartData = thisInstance.generateData();
			thisInstance.getPlotContainer().bind("plothover", function (event, pos, item) {
				if (item) {
					$(this).css( 'cursor', 'pointer' );
				}else{
					$(this).css( 'cursor', 'auto' );
				}
			});
			thisInstance.getPlotContainer().bind("plotclick", function (event, pos, item) {			
				if(item) {
					$(chartData['links']).each(function(){
						if(item.seriesIndex == this[0])
							window.location.href = this[1];
					});
				}
			});
		}
	});
</script>
{/literal}
<div class="dashboardWidgetHeader">	
{foreach key=index item=cssModel from=$STYLES}
	<link rel="{$cssModel->getRel()}" href="{$cssModel->getHref()}" type="{$cssModel->getType()}" media="{$cssModel->getMedia()}" />
{/foreach}
{foreach key=index item=jsModel from=$SCRIPTS}
	<script type="{$jsModel->getType()}" src="{$jsModel->getSrc()}"></script>
{/foreach}
{assign var=WIDGET_WIDTH value=$WIDGET->getWidth()}
<div class="row-fluid">
	<div class="span8">
		<div class="dashboardTitle" title="{vtranslate($WIDGET->getTitle(), $MODULE_NAME)}"><strong>&nbsp;&nbsp;{vtranslate($WIDGET->getTitle(), $MODULE_NAME)}</strong></div>
	</div>
	<div class="span4">
		<div class="box pull-right">
			{include file="dashboards/DashboardHeaderIcons.tpl"|@vtemplate_path:$MODULE_NAME}
		</div>
	</div>
</div>
<hr class="widgetHr"/>
<div class="row-fluid">
	<div class="span6">
		<span class="icon-calendar iconMiddle margintop3"></span>
		<input type="text" name="createdtime" title="{vtranslate('Created Time', $MODULE_NAME)}" class="dateRange widgetFilter input-mini width90" />
	</div>
	<div class="span6">
		<span class="icon-user iconMiddle margintop3"></span>
		{assign var=ALL_ACTIVEUSER_LIST value=$CURRENTUSER->getAccessibleUsers()}
		{assign var=LOGGED_USER_ID value=$LOGGEDUSERID}
		<select class="widgetFilter width90 owner" title="{vtranslate('LBL_OWNER')}" name="owner" >
			<optgroup label="{vtranslate('LBL_USERS')}">
				{foreach key=OWNER_ID item=OWNER_NAME from=$ALL_ACTIVEUSER_LIST}
					<option title="{$OWNER_NAME}" {if $OWNER_ID eq $LOGGED_USER_ID } selected {/if} value="{$OWNER_ID}">
						{$OWNER_NAME}
					</option>
				{/foreach}
			</optgroup>
		</select>
		<div class="pull-right">
			&nbsp;
		</div>
	</div>
</div>	
</div>
<div class="dashboardWidgetContent">
	{include file="dashboards/DashBoardWidgetContents.tpl"|@vtemplate_path:$MODULE_NAME}
</div>

