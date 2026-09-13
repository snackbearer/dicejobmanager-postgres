-------------------------------------------------------------
-- Material Types
-------------------------------------------------------------

INSERT INTO material_type (description)
VALUES
    ('Resin'),
    ('Clay');

-------------------------------------------------------------
-- Production Methods
-------------------------------------------------------------

INSERT INTO production_method (description)
VALUES
    ('Dirty Pour'),
    ('Cloud'),
    ('Petri'),
    ('Swirl'),
    ('Slush Pour'),
    ('Inserts'),
    ('Galaxy'),
    ('Marble'),
    ('Mokume gane'),
    ('Agate style'),
    ('Split pour'),
    ('Layered');

-------------------------------------------------------------
-- Allowed Materials for a Production Method
-------------------------------------------------------------

INSERT INTO production_method_material (production_method_id, material_type_id)
SELECT pm.production_method_id, mt.material_type_id
FROM production_method pm
JOIN material_type mt ON TRUE
WHERE (pm.description, mt.description) IN (
    ('Dirty Pour', 'Resin'),
    ('Cloud', 'Resin'),
    ('Petri', 'Resin'),
    ('Swirl', 'Resin'),
    ('Slush Pour', 'Resin'),
    ('Inserts', 'Resin'),
    ('Galaxy', 'Resin'),
    ('Marble', 'Resin'),
    ('Marble', 'Clay'),
    ('Mokume gane', 'Clay'),
    ('Agate style', 'Clay'),
    ('Split pour', 'Resin'),
    ('Layered', 'Resin'),
    ('Layered', 'Clay')
);

-------------------------------------------------------------
-- Job Number Colours
-------------------------------------------------------------

INSERT INTO dice_job_number_colour (dice_job_number_colour_name)
VALUES
    ('Black'),
    ('White'),
    ('Gold'),
    ('Silver'),
    ('Red'),
    ('Green'),
    ('Blue');

-------------------------------------------------------------
-- Material Stock
-------------------------------------------------------------

INSERT INTO material_stock (colour_name, material_type_id, quantity_in_stock)
SELECT v.colour_name, mt.material_type_id, v.quantity_in_stock
FROM (
    VALUES
        ('Red', 'Resin', 10),
        ('Crimson', 'Resin', 8),
        ('Maroon', 'Resin', 6),
        ('Orange', 'Resin', 10),
        ('Amber', 'Resin', 7),
        ('Yellow', 'Resin', 10),
        ('Gold', 'Resin', 8),
        ('Lime', 'Resin', 7),
        ('Green', 'Resin', 10),
        ('Forest', 'Resin', 6),
        ('Teal', 'Resin', 8),
        ('Turquoise', 'Resin', 7),
        ('Cyan', 'Resin', 8),
        ('Sky Blue', 'Resin', 9),
        ('Blue', 'Resin', 10),
        ('Navy', 'Resin', 8),
        ('Royal Blue', 'Resin', 7),
        ('Purple', 'Resin', 9),
        ('Violet', 'Resin', 7),
        ('Lavender', 'Resin', 6),
        ('Magenta', 'Resin', 7),
        ('Pink', 'Resin', 9),
        ('Hot Pink', 'Resin', 6),
        ('Coral', 'Resin', 7),
        ('Peach', 'Resin', 6),
        ('Cream', 'Resin', 8),
        ('Ivory', 'Resin', 7),
        ('Pearl', 'Resin', 6),
        ('White', 'Resin', 10),
        ('Silver', 'Resin', 8),
        ('Smoke', 'Resin', 7),
        ('Grey', 'Resin', 8),
        ('Charcoal', 'Resin', 7),
        ('Black', 'Resin', 10),
        ('Copper', 'Resin', 6),
        ('Bronze', 'Resin', 6),
        ('Clear', 'Resin', 12),
        ('Neon Green', 'Resin', 5),
        ('Neon Pink', 'Resin', 5),
        ('Terracotta', 'Clay', 5),
        ('Stone Grey', 'Clay', 5),
        ('Ochre', 'Clay', 4),
        ('Sand', 'Clay', 5),
        ('Slate', 'Clay', 4),
        ('Rust', 'Clay', 4),
        ('Olive', 'Clay', 4),
        ('Bone', 'Clay', 5),
        ('Umber', 'Clay', 3),
        ('Sienna', 'Clay', 3)
) AS v(colour_name, material_type_description, quantity_in_stock)
JOIN material_type mt ON mt.description = v.material_type_description;
