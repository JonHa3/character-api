<#import "layout.ftlh" as layout>
<@layout.page title="Home">
    <h1>Character Gallery</h1>
    <p class="intro">A collection of iconic cartoon characters from across different animated universes.</p>

    <#if characters?has_content>
        <div class="gallery">
            <#list characters as c>
                <a href="/characters/${c.characterId?c}">
                    <div class="card">
                        <img src="${c.imageUrl?has_content?then(c.imageUrl, '/images/placeholder.svg')}" alt="${c.name}">
                        <h2>${c.name}</h2>
                        <ul>
                            <li>Network: ${c.network!'Unknown'}</li>
                            <li>Species: ${c.species!'Unknown'}</li>
                        </ul>
                    </div>
                </a>
            </#list>
        </div>
    <#else>
        <p class="empty">No characters found.</p>
    </#if>
</@layout.page>
