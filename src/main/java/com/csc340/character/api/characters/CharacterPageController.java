package com.csc340.character.api.characters;

import jakarta.validation.Valid;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.LinkedHashMap;
import java.util.Map;

/**
 * Serves the HTML pages. Separate from CharacterController, which serves JSON at /api/characters.
 * Talks to the service layer directly, never to the REST API over HTTP.
 */
@Controller
public class CharacterPageController {

    private final CharacterService service;

    public CharacterPageController(CharacterService service) {
        this.service = service;
    }

    // Trim form and query values, and turn empty boxes into null instead of ""
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(String.class, new StringTrimmerEditor(true));
    }

    // Gallery, with optional search: /?name=gum&network=Cartoon%20Network
    @GetMapping("/")
    public String gallery(@RequestParam(required = false) String name,
                          @RequestParam(required = false) String network,
                          Model model) {
        model.addAttribute("characters", service.search(name, network));
        model.addAttribute("networks", service.findAllNetworks());
        // Send the typed values back so the inputs stay filled in after searching
        model.addAttribute("name", name);
        model.addAttribute("network", network);
        return "index";
    }

    // Details for one character
    @GetMapping("/characters/{id}")
    public String details(@PathVariable Long id, Model model) {
        model.addAttribute("character", service.findById(id));
        return "details";
    }

    // Empty add form
    @GetMapping("/characters/new")
    public String newForm(Model model) {
        model.addAttribute("character", new CartoonCharacter());
        addFormSettings(model, "Add a New Character", "/characters", "Add Character", "/");
        return "character-form";
    }

    // Add form submitted
    @PostMapping("/characters")
    public String create(@Valid @ModelAttribute("character") CartoonCharacter character,
                         BindingResult result,
                         Model model,
                         RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            // Show the form again with the typed values and the error messages
            model.addAttribute("errors", errorsByField(result));
            addFormSettings(model, "Add a New Character", "/characters", "Add Character", "/");
            return "character-form";
        }
        CartoonCharacter saved = service.create(character);
        redirectAttributes.addFlashAttribute("message", saved.getName() + " was added");
        // Post/Redirect/Get: refreshing the gallery cannot submit the form again
        return "redirect:/";
    }

    // Lets one template serve both the add form and the edit form
    private void addFormSettings(Model model, String title, String action, String submitLabel, String cancelUrl) {
        model.addAttribute("formTitle", title);
        model.addAttribute("formAction", action);
        model.addAttribute("submitLabel", submitLabel);
        model.addAttribute("cancelUrl", cancelUrl);
    }

    // Field name -> first error message, for example "name" -> "Name is required"
    private Map<String, String> errorsByField(BindingResult result) {
        Map<String, String> errors = new LinkedHashMap<>();
        for (FieldError error : result.getFieldErrors()) {
            String message = error.isBindingFailure() ? "Please enter a valid value" : error.getDefaultMessage();
            errors.putIfAbsent(error.getField(), message);
        }
        return errors;
    }
}
