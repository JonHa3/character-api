<#import "layout.ftlh" as layout>
<#-- Used for unknown character ids, and by Spring Boot for any other error page (unknown URL, etc.) -->
<#assign code = (status!404)?c>
<@layout.page title=(code == "404")?then("Not Found", "Something Went Wrong")>
    <div class="page-content error-page">
        <img src="/images/placeholder.svg" alt="">
        <#if code == "404">
            <h1>Not Found</h1>
            <p>${errorMessage!"Sorry, we couldn't find that page."}</p>
        <#else>
            <h1>Something Went Wrong</h1>
            <p>Sorry, something went wrong on our end. Please try again.</p>
        </#if>
        <p><a href="/">&larr; Back to the gallery</a></p>
    </div>
</@layout.page>
