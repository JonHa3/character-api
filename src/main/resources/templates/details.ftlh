<#import "layout.ftlh" as layout>
<@layout.page title=character.name>
    <div class="page-content">
        <h1>${character.name}</h1>
        <img src="${character.imageUrl?has_content?then(character.imageUrl, '/images/placeholder.svg')}" alt="${character.name}">

        <h2>Backstory</h2>
        <p>${character.description}</p>

        <h2>Network</h2>
        <p>${character.network!'Unknown'}</p>

        <h2>Species</h2>
        <p>${character.species!'Unknown'}</p>

        <h2>First Appearance</h2>
        <p><#if character.firstAppearance??>${character.firstAppearance?string("MMMM d, yyyy")}<#else>Unknown</#if></p>

        <p><a href="/">&larr; Back to the gallery</a></p>
    </div>
</@layout.page>
