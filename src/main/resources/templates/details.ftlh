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
        <p><#if character.firstAppearance??>${character.firstAppearance?string?date("yyyy-MM-dd")?string("MMMM d, yyyy")}<#else>Unknown</#if></p>

        <div class="actions">
            <a class="button" href="/characters/${character.characterId?c}/edit">Edit</a>
            <form method="post" action="/characters/${character.characterId?c}/delete"
                  onsubmit="return confirm('Delete ${character.name?js_string}? This cannot be undone.');">
                <button type="submit" class="danger">Delete</button>
            </form>
        </div>

        <p><a href="/">&larr; Back to the gallery</a></p>
    </div>
</@layout.page>
