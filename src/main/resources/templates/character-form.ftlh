<#import "layout.ftlh" as layout>
<@layout.page title="Add a Character">
    <h1>Add a New Character</h1>
    <form>
        <label>Name</label>
        <input type="text" name="name">
        <label>Universe</label>
        <input type="text" name="universe">
        <label>Role</label>
        <input type="text" name="role">
        <label>Short description</label>
        <textarea></textarea>
        <label>URL</label>
        <input type="url" name="url">
        <button type="submit">Add Character</button>
    </form>
</@layout.page>
