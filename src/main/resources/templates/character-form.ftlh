<#import "layout.ftlh" as layout>
<#-- Used for both Add and Edit. The controller sets formTitle, formAction, submitLabel and cancelUrl. -->
<#macro fieldError field>
    <#if errors?? && errors[field]??>
        <span class="field-error">${errors[field]}</span>
    </#if>
</#macro>
<@layout.page title=formTitle>
    <h1>${formTitle}</h1>

    <form method="post" action="${formAction}" novalidate>
        <label for="name">Name *</label>
        <input type="text" id="name" name="name" value="${character.name!}">
        <@fieldError "name"/>

        <label for="description">Description *</label>
        <textarea id="description" name="description" rows="5">${character.description!}</textarea>
        <@fieldError "description"/>

        <label for="network">Network</label>
        <input type="text" id="network" name="network" value="${character.network!}" placeholder="e.g. Cartoon Network">
        <@fieldError "network"/>

        <label for="species">Species</label>
        <input type="text" id="species" name="species" value="${character.species!}" placeholder="e.g. Human">
        <@fieldError "species"/>

        <label for="firstAppearance">First Appearance</label>
        <input type="date" id="firstAppearance" name="firstAppearance" value="${(character.firstAppearance)!}">
        <@fieldError "firstAppearance"/>

        <label for="imageUrl">Image URL</label>
        <input type="text" id="imageUrl" name="imageUrl" value="${character.imageUrl!}" placeholder="https://... or /images/aang.png">
        <@fieldError "imageUrl"/>

        <button type="submit">${submitLabel}</button>
        <a class="cancel" href="${cancelUrl}">Cancel</a>
    </form>
</@layout.page>
