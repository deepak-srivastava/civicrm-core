{*
 +--------------------------------------------------------------------+
 | CiviCRM version 4.7                                                |
 +--------------------------------------------------------------------+
 | Copyright CiviCRM LLC (c) 2004-2017                                |
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
{* Callback snippet: Load payment processor *}
  {if $action & 1024}
    {include file="CRM/Event/Form/Registration/PreviewHeader.tpl"}
  {/if}

  {include file="CRM/common/TrackingFields.tpl"}

  <div class="crm-event-id-{$event.id} crm-block crm-event-register-form-block">

    {* moved to tpl since need to show only for primary participant page *}
    {if $requireApprovalMsg || $waitlistMsg}
      <div id="id-waitlist-approval-msg" class="messages status no-popup">
        {if $requireApprovalMsg}
          <div id="id-req-approval-msg">{$requireApprovalMsg}</div>
        {/if}
        {if $waitlistMsg}
          <div id="id-waitlist-msg">{$waitlistMsg}</div>
        {/if}
      </div>
    {/if}

    {if $contact_id}
      <div class="messages status no-popup crm-not-you-message" id="crm-event-register-different">
        {ts 1=$display_name}Welcome %1{/ts}. (<a
          href="{crmURL p='civicrm/event/register' q="cid=0&reset=1&id=`$event.id`"}"
          title="{ts}Click here to register a different person for this event.{/ts}">{ts 1=$display_name}Not %1, or want to register a different person{/ts}</a>?)
      </div>
    {/if}
    {if $event.intro_text}
      <div id="intro_text" class="crm-public-form-item crm-section intro_text-section">
        <p>{$event.intro_text}</p>
      </div>
    {/if}

    {include file="CRM/common/cidzero.tpl"}
    {if $pcpSupporterText}
      <div class="crm-public-form-item crm-section pcpSupporterText-section">
        <div class="content">{$pcpSupporterText}</div>
      </div>
    {/if}

    {if $form.additional_participants.html}
      <div class="crm-public-form-item crm-section additional_participants-section" id="noOfparticipants">
        <div class="label">{$form.additional_participants.label} <span class="crm-marker" title="{ts}This field is required.{/ts}">*</span></div>
        <div class="content">
          {$form.additional_participants.html}{if $contact_id || $contact_id == NULL} &nbsp; ({ts}including yourself{/ts}){/if}
          <br/>
          <span
            class="description">{ts}Fill in your registration information on this page. If you are registering additional people, you will be able to enter their registration information after you complete this page and click &quot;Continue&quot;.{/ts}</span>
        </div>
        <div class="clear"></div>
      </div>
    {/if}

    <div class="crm-public-form-item crm-section cms_user-section">
      {* User account registration option. Displays if enabled for one of the profiles on this page. *}
      {include file="CRM/common/CMSUser.tpl"}
    </div>

    <div class="crm-public-form-item crm-section custom_pre-section">
      {* Display "Top of page" profile immediately after the introductory text *}
      {include file="CRM/UF/Form/Block.tpl" fields=$customPre}
    </div>

    {if $priceSet}
      {if ! $quickConfig}<fieldset id="priceset" class="crm-public-form-item crm-group priceset-group">
        <legend>{$event.fee_label}</legend>{/if}
      {include file="CRM/Price/Form/PriceSet.tpl" extends="Event"}
      {include file="CRM/Price/Form/ParticipantCount.tpl"}
      {if ! $quickConfig}</fieldset>{/if}
    {/if}

    {crmRegion name='event-main-pledge-block'}
    {*if $pledgeBlock*}
      {if $is_pledge_payment}
      <div class="crm-public-form-item crm-section {$form.pledge_amount.name}-section">
        <div class="label">{$form.pledge_amount.label}&nbsp;<span class="crm-marker">*</span></div>
        <div class="content">{$form.pledge_amount.html}</div>
        <div class="clear"></div>
      </div>
      {else}
        <div class="crm-public-form-item crm-section {$form.is_pledge.name}-section">
          <div class="label">&nbsp;</div>
          <div class="content">
            {$form.is_pledge.html}&nbsp;
            {if $is_pledge_interval}
              {$form.pledge_frequency_interval.html}&nbsp;
            {/if}
            {$form.pledge_frequency_unit.html}<span id="pledge_installments_num">&nbsp;{ts}for{/ts}&nbsp;{$form.pledge_installments.html}&nbsp;{ts}installments.{/ts}</span>
          </div>
          <div class="clear"></div>
          {if $start_date_editable}
            {if $is_date}
              <div class="label">{$form.start_date.label}</div><div class="content">{include file="CRM/common/jcalendar.tpl" elementName=start_date}</div>
            {else}
              <div class="label">{$form.start_date.label}</div><div class="content">{$form.start_date.html}</div>
            {/if}
          {else}
            <div class="label">{$form.start_date.label}</div>
            <div class="content">{$start_date_display|date_format}</div>
          {/if}
        <div class="clear"></div>
        </div>
      {/if}
    {*/if*}
    {/crmRegion}

    {if $pcp && $is_honor_roll }
      <fieldset class="crm-public-form-item crm-group pcp-group">
        <div class="crm-public-form-item crm-section pcp-section">
          <div class="crm-public-form-item crm-section display_in_roll-section">
            <div class="content">
              {$form.pcp_display_in_roll.html} &nbsp;
              {$form.pcp_display_in_roll.label}
            </div>
            <div class="clear"></div>
          </div>
          <div id="nameID" class="crm-public-form-item crm-section is_anonymous-section">
            <div class="content">
              {$form.pcp_is_anonymous.html}
            </div>
            <div class="clear"></div>
          </div>
          <div id="nickID" class="crm-public-form-item crm-section pcp_roll_nickname-section">
            <div class="label">{$form.pcp_roll_nickname.label}</div>
            <div class="content">{$form.pcp_roll_nickname.html}
              <div
                class="description">{ts}Enter the name you want listed with this contribution. You can use a nick name like 'The Jones Family' or 'Sarah and Sam'.{/ts}</div>
            </div>
            <div class="clear"></div>
          </div>
          <div id="personalNoteID" class="crm-public-form-item crm-section pcp_personal_note-section">
            <div class="label">{$form.pcp_personal_note.label}</div>
            <div class="content">
              {$form.pcp_personal_note.html}
              <div class="description">{ts}Enter a message to accompany this contribution.{/ts}</div>
            </div>
            <div class="clear"></div>
          </div>
        </div>
      </fieldset>
    {/if}

    {if $form.payment_processor_id.label}
      <fieldset class="crm-public-form-item crm-group payment_options-group" style="display:none;">
        <legend>{ts}Payment Options{/ts}</legend>
        <div class="crm-section payment_processor-section">
          <div class="label">{$form.payment_processor_id.label}</div>
          <div class="content">{$form.payment_processor_id.html}</div>
          <div class="clear"></div>
        </div>
      </fieldset>
    {/if}

    {if $priceSet}
      {include file='CRM/Core/BillingBlockWrapper.tpl'}
    {/if}

    <div class="crm-public-form-item crm-section custom_pre-section">
      {include file="CRM/UF/Form/Block.tpl" fields=$customPost}
    </div>

    {if $isCaptcha}
      {include file='CRM/common/ReCAPTCHA.tpl'}
    {/if}

    <div id="crm-submit-buttons" class="crm-submit-buttons">
      {include file="CRM/common/formButtons.tpl" location="bottom"}
    </div>

    {if $event.footer_text}
      <div id="footer_text" class="crm-public-form-item crm-section event_footer_text-section">
        <p>{$event.footer_text}</p>
      </div>
    {/if}
  </div>
  <script type="text/javascript">
    {literal}

    cj("#additional_participants").change(function () {
      skipPaymentMethod();
    });

  {/literal}
  {if $pcp && $is_honor_roll }
    pcpAnonymous();
  {/if}
  {literal}

  function allowParticipant() {
    {/literal}{if $allowGroupOnWaitlist}{literal}
    var additionalParticipants = cj('#additional_participants').val();
    var pricesetParticipantCount = 0;
    {/literal}{if $priceSet}{literal}
    pricesetParticipantCount = pPartiCount;
    {/literal}{/if}{literal}

    allowGroupOnWaitlist(additionalParticipants, pricesetParticipantCount);
    {/literal}{/if}{literal}
  }

  {/literal}{if $allowGroupOnWaitlist}{literal}
  allowGroupOnWaitlist(0, 0);
  {/literal}{/if}{literal}

  function allowGroupOnWaitlist(additionalParticipants, pricesetParticipantCount) {
    {/literal}{if $isAdditionalParticipants}{literal}
    if (!additionalParticipants) {
      additionalParticipants = cj('#additional_participants').val();
    }
    {/literal}{else}{literal}
    additionalParticipants = 0;
    {/literal}{/if}{literal}

    additionalParticipants = parseInt(additionalParticipants);
    if (!additionalParticipants) {
      additionalParticipants = 0;
    }

    var availableRegistrations = {/literal}'{$availableRegistrations}'{literal};
    var totalParticipants = parseInt(additionalParticipants) + 1;

    if (pricesetParticipantCount) {
      // add priceset count if any
      totalParticipants += parseInt(pricesetParticipantCount) - 1;
    }
    var isrequireApproval = {/literal}'{$requireApprovalMsg}'{literal};

    if (totalParticipants > availableRegistrations) {
      cj("#id-waitlist-msg").show();
      cj("#id-waitlist-approval-msg").show();

      //set the value for hidden bypass payment.
      cj("#bypass_payment").val(1);
    }
    else {
      if (isrequireApproval) {
        cj("#id-waitlist-approval-msg").show();
        cj("#id-waitlist-msg").hide();
        cj("#bypass_payment").val(1);
      }
      else {
        cj("#id-waitlist-approval-msg").hide();
        cj("#bypass_payment").val(0);
      }
      //reset value since user don't want or not eligible for waitlist
      skipPaymentMethod();
    }
  }

  {/literal}
  {if $pcp && $is_honor_roll }{literal}
  function pcpAnonymous() {
    // clear nickname field if anonymous is true
    if (document.getElementsByName("pcp_is_anonymous")[1].checked) {
      document.getElementById('pcp_roll_nickname').value = '';
    }
    if (!document.getElementsByName("pcp_display_in_roll")[0].checked) {
      cj('#nickID, #nameID, #personalNoteID').hide();
    }
    else {
      if (document.getElementsByName("pcp_is_anonymous")[0].checked) {
        cj('#nameID, #nickID, #personalNoteID').show();
      }
      else {
        cj('#nameID').show();
        cj('#nickID, #personalNoteID').hide();
      }
    }
  }
  {/literal}
  {/if}
  {literal}

</script>
{/literal}
