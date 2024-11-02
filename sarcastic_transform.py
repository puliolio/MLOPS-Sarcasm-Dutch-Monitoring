
import tensorflow as tf

LABEL_KEY = "is_sarcastic"
FEATURE_KEY = "headline"

def transformed_name(key):
    """Renaming transformed features"""
    return key + "_xf"

def preprocessing_fn(inputs):
    """
    Preprocess input features into transformed features

    Args:
        inputs: map from feature keys to raw features.

    Return:
        outputs: map from feature keys to transformed features.
    """

    outputs = {}

    # Lowercase the headline text and handle missing strings
    outputs[transformed_name(FEATURE_KEY)] = tf.strings.lower(
        tf.where(
            tf.strings.length(inputs[FEATURE_KEY]) > 0,
            inputs[FEATURE_KEY],
            tf.constant("", dtype=tf.string)
        )
    )

    # Cast the 'label' to int64
    outputs[transformed_name(LABEL_KEY)] = tf.cast(inputs[LABEL_KEY], tf.int64)

    return outputs
