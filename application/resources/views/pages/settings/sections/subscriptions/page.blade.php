@extends('pages.settings.ajaxwrapper')
@section('settings-page')
    <!--settings-->
    <form class="form" id="settingsFormSubscriptions">
        <!--form text tem-->
        <div class="form-group row">
            <label class="col-12 control-label col-form-label">{{ cleanLang(__('lang.subscription_prefix')) }}</label>
            <div class="col-12">
                <input type="text" class="form-control form-control-sm" id="settings_subscriptions_prefix"
                    name="settings_subscriptions_prefix" value="{{ $settings->settings_subscriptions_prefix ?? '' }}">
            </div>
        </div>

        <!--buttons-->
        <div class="text-right">
            <button type="submit" id="commonModalSubmitButton" class="btn btn-rounded-x btn-danger waves-effect text-left"
                data-url="/settings/subscriptions" data-loading-target="" data-ajax-type="PUT" data-type="form"
                data-on-start-submit-button="disable">{{ cleanLang(__('lang.save_changes')) }}</button>
        </div>
    </form>

    <!--settings documentation help-->
@endsection
