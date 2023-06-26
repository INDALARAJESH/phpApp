@extends('pages.settings.ajaxwrapper')
@section('settings-page')
    <!-- action buttons -->
    @include('pages.settings.sections.tickets.misc.list-page-actions')
    <!-- action buttons -->

    <!--heading-->
    @include('pages.settings.sections.tickets.table.table')
    <div>

    </div>
@endsection
