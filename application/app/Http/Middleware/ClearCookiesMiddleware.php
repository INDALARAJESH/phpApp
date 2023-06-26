<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\Cookie;

class ClearCookiesMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure(\Illuminate\Http\Request): (\Illuminate\Http\Response|\Illuminate\Http\RedirectResponse)  $next
     * @return \Illuminate\Http\Response|\Illuminate\Http\RedirectResponse
     */
    public function handle(Request $request, Closure $next)
    {
        $response = $next($request);

        // Set the cookies you want to clear
        $cookiesToClear = [
            'crm_session',
            'remember_web_59ba36addc2b2f9401580f014c7f58ea4e30989d',
            // Add more cookies to clear if needed
        ];

        // $expiration = Carbon::now()->addSeconds(10); // 300 seconds = 5 minutes

        foreach ($cookiesToClear as $cookieName) {
            $response->cookie(Cookie::forget($cookieName)->withExpires(time()+10));
        }

        return $response;
    }
}
