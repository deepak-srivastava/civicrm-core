{*
 +--------------------------------------------------------------------+
 | CiviCRM version 4.4                                                |
 +--------------------------------------------------------------------+
 | Copyright CiviCRM LLC (c) 2004-2013                                |
 +--------------------------------------------------------------------+
 | This file is a part of CiviCRM.                                    |
 |                                                                    |
 | CiviCRM is free software; you can copy, modify, and distribute it  |
 | under the terms of the GNU Affero General Public License           |
 | Version 3, 19 November 2007 and the CiviCRM Licensing Exception.   |
 |                                                                    |
 | CiviCRM is distributed in the hope that it will be useful, but     |
 | WITHOUT ANY WARRANTY; without even the implied warranty of         |
 | MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.               |
 | See the GNU Affero General Public License for more details.        |
 |                                                                    |
 | You should have received a copy of the GNU Affero General Public   |
 | License and the CiviCRM Licensing Exception along                  |
 | with this program; if not, contact CiviCRM LLC                     |
 | at info[AT]civicrm[DOT]org. If you have questions about the        |
 | GNU Affero General Public License or the licensing of CiviCRM,     |
 | see the CiviCRM license FAQ at http://civicrm.org/licensing        |
 +--------------------------------------------------------------------+
*}
{if !$printOnly} {* NO print section starts *}
{if $criteriaForm}
<div class="crm-report-criteria"> {* criteria section starts *}
  <div class="crm-accordion-wrapper crm-report_criteria-accordion {if $rows}collapsed{/if}">
    <div class="crm-accordion-header">
      {ts}Report Configuration{/ts}
    </div><!-- /.crm-accordion-header -->
    <div class="crm-accordion-body">
      <div id="mainTabContainer">
        {*tab navigation bar*}
        <ul>
          {if $colGroups}
            <li id="tab_col-groups" class="crm-tab-button ui-corner-all">
              <a title="Columns" href="#col-groups">Columns</a>
            </li>
          {/if}
          {if $groupByElements}
            <li id="tab_group-by-elements" class="crm-tab-button ui-corner-all">
              <a title="Group By" href="#group-by-elements">Group By</a>
            </li>
          {/if}
          {if $orderByOptions}
            <li id="tab_order-by-elements" class="crm-tab-button ui-corner-all">
              <a title="Order By" href="#order-by-elements">Order By</a>
            </li>
          {/if}
          {if $form.options.html}
            <li id="tab_other-options" class="crm-tab-button ui-corner-all">
              <a title="Other Options" href="#other-options">Options</a>
            </li>
          {/if}
          {if $filters}
            <li id="tab_set-filters" class="crm-tab-button ui-corner-all">
              <a title="Filters" href="#set-filters">Filters</a>
            </li>
          {/if}
          {if $instanceForm OR $instanceFormError}
            <li id="tab_settings" class="crm-tab-button ui-corner-all">
              <a title="Settings" href="#settings">General Settings</a>
            </li>
            <li id="tab_email" class="crm-tab-button ui-corner-all">
              <a title="Email" href="#email">Email Settings</a>
            </li>
            <li id="tab_other" class="crm-tab-button ui-corner-all">
              <a title="Other" href="#other">Other Settings</a>
            </li>
          {/if}
        </ul>

        {*criteria*}
        {include file="CRM/Report/Form/Criteria.tpl"}

        {*settings*}
        {if $instanceForm OR $instanceFormError}
          {include file="CRM/Report/Form/Instance.tpl"}
        {/if}
      </div> {* end mainTabContainer *}
    </div> {* crm-accordion-body *}
  </div> {* crm-accordion-wrapper *}
</div> {* criteria section ends *}
{/if}

<div>{$form.buttons.html}</div>

{assign var=save value="_qf_"|cat:$form.formName|cat:"_submit_save"}
{assign var=next value="_qf_"|cat:$form.formName|cat:"_submit_next"}
<div class="crm-submit-buttons">
  {$form.$save.html}
  {if $mode neq 'template' && $form.$next}
    {$form.$next.html}
  {/if}
</div>

{if $updateReportButton}
<div id='update-button' class="crm-submit-buttons">
  {$form.$save.html}
  {if $mode neq 'template' && $form.$next}
    {$form.$next.html}
  {/if}
</div>
{/if}

{literal}
<script type="text/javascript">
cj(function() {
  cj("#mainTabContainer").tabs()
  cj().crmAccordions();
});
</script>
{/literal}

{/if} {* NO print section ends *}
