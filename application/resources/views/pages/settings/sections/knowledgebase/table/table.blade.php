<div class="table-responsive" id="knowledgebase-categories-table">
    @if (@count($categories ?? []) > 0)
        <table id="knowledgebase-categories" class="table m-t-0 m-b-0 table-hover no-wrap contact-list" data-page-size="10"
            data-type="form" data-form-id="knowledgebase-categories" data-ajax-type="post"
            data-url="{{ url('settings/knowledgebase/update-positions') }}">
            <thead>
                <tr>
                    <th class="category_col_name">{{ cleanLang(__('lang.name')) }}</th>
                    <th class="category_col_type">@lang('lang.type')</th>
                    <th class="category_col_articles">{{ cleanLang(__('lang.articles')) }}</th>
                    <th class="category_col_visible_to">{{ cleanLang(__('lang.visible_to')) }}</th>
                    <th class="category_col_created_by">{{ cleanLang(__('lang.created_by')) }}</th>
                    <th class="category_col_action"><a href="javascript:void(0)">{{ cleanLang(__('lang.action')) }}</a>
                    </th>
                </tr>
            </thead>
            <tbody id="categories-td-container">
                <!--ajax content here-->
                @include('pages.settings.sections.knowledgebase.table.ajax')
                <!--ajax content here-->
            </tbody>
        </table>
    @endif
    @if (@count($categories ?? []) == 0)
        <!--nothing found-->
        @include('notifications.no-results-found')
        <!--nothing found-->
    @endif


</div>
